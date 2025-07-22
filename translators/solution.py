"""Translator for Python solutions to Dafny methods"""

from typing import Dict, Tuple
from pathlib import Path

from .base import BaseTranslator
from ..core.models import TranslationTask, TranslationResult
from ..utils.llm import extract_dafny_code


class SolutionTranslator(BaseTranslator):
    """Translates Python functions to Dafny methods"""
    
    def get_prompt_template(self) -> Dict[str, str]:
        """Load solution prompt template"""
        return self.load_prompt_from_file("solution.yaml")
        
    def format_prompt(self, template: Dict[str, str], **kwargs) -> Tuple[str, str]:
        """Format the solution prompt"""
        system_prompt = template['system']
        user_prompt = template['user'].format(
            problem_statement=kwargs['problem_statement'],
            python_code=kwargs['python_code'],
            entry_point=kwargs['entry_point']
        )
        return system_prompt, user_prompt
        
    def extract_code(self, response) -> str:
        """Extract Dafny code from response"""
        return extract_dafny_code(response)
        
    def translate(self, task: TranslationTask, work_dir: Path) -> TranslationResult:
        """Translate a Python solution to Dafny"""
        template = self.get_prompt_template()
        system_prompt, user_prompt = self.format_prompt(
            template,
            problem_statement=task.problem_statement,
            python_code=task.python_code,
            entry_point=task.entry_point
        )
        
        messages = [{"role": "user", "content": user_prompt}]
        
        return self.translate_with_retries(messages, system_prompt, work_dir) 