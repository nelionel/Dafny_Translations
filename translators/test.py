"""Translator for Python tests to Dafny test methods"""

import re
from typing import Dict, Tuple
from pathlib import Path

from .base import BaseTranslator
from ..core.models import TranslationTask, TestTranslationResult, TranslationResult
from ..utils.llm import extract_dafny_code, extract_dummy_method


class TestTranslator(BaseTranslator):
    """Translates Python test assertions to Dafny test methods"""
    
    def get_prompt_template(self) -> Dict[str, str]:
        """Load test prompt template"""
        return self.load_prompt_from_file("test.yaml")
        
    def format_prompt(self, template: Dict[str, str], **kwargs) -> Tuple[str, str]:
        """Format the test prompt"""
        system_prompt = template['system']
        user_prompt = template['user'].format(
            entry_point=kwargs['entry_point'],
            test_code=kwargs['test_code'],
            dafny_solution_code=kwargs['dafny_solution_code']
        )
        return system_prompt, user_prompt
        
    def extract_code(self, response) -> str:
        """Extract Dafny test code from response"""
        return extract_dafny_code(response)
        
    def translate(self, task: TranslationTask, solution_result: TranslationResult, work_dir: Path) -> TestTranslationResult:
        """Translate Python tests to Dafny tests"""
        template = self.get_prompt_template()
        system_prompt, user_prompt = self.format_prompt(
            template,
            entry_point=task.entry_point,
            test_code=task.test_code,
            dafny_solution_code=solution_result.dafny_code
        )
        
        messages = [{"role": "user", "content": user_prompt}]
        
        # Use parent's translate_with_retries but customize the result
        base_result = self.translate_with_retries(messages, system_prompt, work_dir)
        
        # Extract dummy method from the full conversation
        dummy_method = self._extract_dummy_from_conversation(base_result.conversation_history)
        
        # Create TestTranslationResult with dummy method
        return TestTranslationResult(
            dafny_code=base_result.dafny_code,
            attempts=base_result.attempts,
            input_tokens=base_result.input_tokens,
            output_tokens=base_result.output_tokens,
            conversation_history=base_result.conversation_history,
            compilation_error=base_result.compilation_error,
            dummy_method=dummy_method
        )
        
    def _extract_dummy_from_conversation(self, conversation_history) -> str:
        """Extract dummy method from conversation history"""
        for role, content in conversation_history:
            if role == "assistant":
                dummy = extract_dummy_method(content)
                if dummy:
                    return dummy
        return ""
        
    def _get_correction_prompt(self, error: str) -> str:
        """Get the correction prompt with optional dummy note"""
        template = self.get_prompt_template()
        missing_dummy_note = ""
        
        # Check if error indicates missing dummy
        if not hasattr(self, '_last_dummy') or not self._last_dummy:
            missing_dummy_note = "\n\n[SYSTEM NOTE]: The error above is likely because you failed to provide a dummy implementation inside a <dummy> block."
            
        return template.get('correction', '').format(
            compilation_error=error,
            missing_dummy_note=missing_dummy_note
        )
        
    def compile_check(self, code: str, work_dir: Path) -> Tuple[bool, str]:
        """Check if generated test code compiles with dummy"""
        # For test compilation, we need to combine dummy + test code
        # Extract dummy from current response
        if hasattr(self, '_current_response'):
            dummy = extract_dummy_method(self._current_response)
            self._last_dummy = dummy
            full_code = f"{dummy}\n\n{code}"
        else:
            full_code = code
            
        result = self.compiler.compile(full_code, work_dir, verify=False)
        return result.status.value == "passed", result.stderr or result.stdout 