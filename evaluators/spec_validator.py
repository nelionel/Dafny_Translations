"""Specification validator for Dafny code"""

from pathlib import Path
from typing import Tuple, Optional, Dict, List, Any
import re
import time
import yaml

from ..core.models import CompilationStatus
from ..core.exceptions import DafnyTranslationError
from .compiler import DafnyCompiler
from ..utils.llm import format_conversation_for_transcript


# SpecValidationResult is now in core.models, so we import it
from ..core.models import SpecValidationResult


class SpecValidator:
    """Validates and improves Dafny specifications"""
    
    def __init__(self, provider, model: str, config):
        self.provider = provider
        self.model = model
        self.config = config
        self.max_attempts = 3
        self.compiler = DafnyCompiler(config.dafny_path, config.compilation_timeout)
        
    def load_prompt_from_file(self, filename: str) -> Dict[str, str]:
        """Load prompt template from YAML file"""
        prompt_path = Path(__file__).parent.parent / "config" / "prompts" / filename
        with open(prompt_path, 'r') as f:
            return yaml.safe_load(f)
        
    def validate_and_improve_specs(self, python_code: str, dafny_code: str, 
                                 work_dir: Path) -> SpecValidationResult:
        """Validate and potentially improve Dafny specifications"""
        validation_messages = []
        current_code = dafny_code
        conversation_history: List[Tuple[str, Any]] = []
        
        # Also determine paths for copying to main dafny_files directory
        # work_dir is evaluations_dir, so parent.parent gets us to the problem dir
        problem_dir = work_dir.parent.parent
        main_dafny_dir = problem_dir / "dafny_files"
        actual_dafny_files_dir = main_dafny_dir / "actual_dafny_files"
        
        # Load prompt template once
        prompt_template = self.load_prompt_from_file("spec_validation.yaml")
        system_prompt = prompt_template["system"]
        
        # Add initial context to conversation history
        conversation_history.append(("system", system_prompt))
        
        for attempt in range(1, self.max_attempts + 1):
            # Get LLM analysis of current specifications
            analysis_result, attempt_conversation = self._analyze_specifications_with_conversation(
                python_code, current_code, attempt, system_prompt
            )
            
            # Add this attempt's conversation to the full history
            conversation_history.extend(attempt_conversation)
            
            message = f"Attempt {attempt}: {analysis_result['message']}"
            validation_messages.append(message)
            
            if analysis_result['has_proper_specs']:
                # Save improved code if it's different from original
                improved_code = analysis_result['dafny_code']
                if improved_code != dafny_code:
                    # Save to evaluations directory
                    new_spec_path = work_dir / "solution_new_spec.dfy"
                    with open(new_spec_path, 'w') as f:
                        f.write(improved_code)
                    
                    # Also save to main dafny_files directory for easier access
                    main_spec_path = main_dafny_dir / "solution_new_spec.dfy"
                    with open(main_spec_path, 'w') as f:
                        f.write(improved_code)
                    
                    # Also save to actual_dafny_files directory for easy comparison with original
                    actual_spec_path = actual_dafny_files_dir / "solution_new_spec.dfy"
                    with open(actual_spec_path, 'w') as f:
                        f.write(improved_code)
                
                # Write detailed conversation transcript
                self._write_detailed_transcript(
                    work_dir, main_dafny_dir, conversation_history, 
                    python_code, dafny_code, attempt, True, improved_code
                )
                
                return SpecValidationResult(
                    has_proper_specs=True,
                    improved_code=improved_code,
                    attempts=attempt,
                    validation_messages=validation_messages
                )
            
            # Save the attempted improvement for compilation check
            improved_code = analysis_result['dafny_code']
            temp_spec_path = work_dir / f"solution_attempt_{attempt}.dfy"
            with open(temp_spec_path, 'w') as f:
                f.write(improved_code)
            
            # Check if the improved code compiles
            compile_result = self.compiler.compile(improved_code, work_dir)
            
            if compile_result.status != CompilationStatus.PASSED:
                validation_messages.append(f"Attempt {attempt}: Improved code failed to compile")
                # Add compilation failure to conversation
                conversation_history.append(("system", f"COMPILATION FAILED: {compile_result.stderr}"))
                # Continue with original code for next attempt
                continue
            
            # Use the improved code for next iteration
            current_code = improved_code
        
        # Failed to achieve proper specs after max attempts
        # Write detailed conversation transcript
        self._write_detailed_transcript(
            work_dir, main_dafny_dir, conversation_history, 
            python_code, dafny_code, self.max_attempts, False, current_code
        )
        
        # Save the best attempt if it's different from original
        if current_code != dafny_code:
            # Save to evaluations directory
            new_spec_path = work_dir / "solution_new_spec.dfy"
            with open(new_spec_path, 'w') as f:
                f.write(current_code)
            
            # Also save to main dafny_files directory for easier access
            main_spec_path = main_dafny_dir / "solution_new_spec.dfy"
            with open(main_spec_path, 'w') as f:
                f.write(current_code)
            
            # Also save to actual_dafny_files directory for easy comparison with original
            actual_spec_path = actual_dafny_files_dir / "solution_new_spec.dfy"
            with open(actual_spec_path, 'w') as f:
                f.write(current_code)
        
        return SpecValidationResult(
            has_proper_specs=False,
            improved_code=current_code,
            attempts=self.max_attempts,
            validation_messages=validation_messages
        )
    
    def _analyze_specifications_with_conversation(self, python_code: str, dafny_code: str, 
                                                attempt: int, system_prompt: str) -> Tuple[dict, List[Tuple[str, Any]]]:
        """Get LLM analysis of specifications and return conversation history"""
        conversation = []
        
        # Prepare attempt context
        attempt_context = ""
        if attempt > 1:
            attempt_context = f"\n\nThis is attempt {attempt} to improve the specifications. Please analyze the current version and improve it further if needed."
        
        # Load prompt template from YAML file
        prompt_template = self.load_prompt_from_file("spec_validation.yaml")
        
        # Format user prompt
        user_prompt = prompt_template["user"].format(
            python_code=python_code,
            dafny_code=dafny_code,
            attempt_context=attempt_context
        )
        
        conversation.append(("user", user_prompt))
        
        messages = [{"role": "user", "content": user_prompt}]
        
        try:
            response = self.provider.create_message(
                model=self.model,
                system_prompt=system_prompt,
                messages=messages,
                max_tokens=self.config.max_tokens
            )
            
            # Add response to conversation
            conversation.append(("assistant", response.content))
            
            # Extract response content for parsing
            response_text = ""
            if hasattr(response, 'content') and isinstance(response.content, list):
                text_parts = []
                for block in response.content:
                    if hasattr(block, 'type') and block.type == 'text' and hasattr(block, 'text'):
                        if block.text and not block.text.isspace():
                            text_parts.append(block.text)
                response_text = "\n".join(text_parts)
            else:
                response_text = str(response.content)
            
            # Parse the response
            parsed_result = self._parse_response(response_text)
            return parsed_result, conversation
            
        except Exception as e:
            error_msg = f"Spec validation API call failed: {e}"
            conversation.append(("system", f"ERROR: {error_msg}"))
            raise DafnyTranslationError(error_msg)
    
    def _write_detailed_transcript(self, work_dir: Path, main_dafny_dir: Path, 
                                 conversation_history: List[Tuple[str, Any]], 
                                 python_code: str, dafny_code: str, attempts: int, 
                                 success: bool, final_code: str):
        """Write detailed conversation transcript in the same format as other transcripts"""
        
        # Write to evaluations directory
        transcript_path = work_dir / "spec_validation_transcript.txt"
        with open(transcript_path, 'w') as f:
            # Write header information
            f.write(f"=== DAFNY SPECIFICATION VALIDATION ===\n")
            f.write(f"Started at: {time.strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write(f"Maximum attempts: {self.max_attempts}\n")
            f.write(f"Attempts made: {attempts}\n")
            f.write(f"Success: {'✓' if success else '❌'}\n\n")
            
            f.write("=== ORIGINAL CONTEXT ===\n")
            f.write("Python Code:\n")
            f.write(python_code)
            f.write("\n\nOriginal Dafny Code:\n")
            f.write(dafny_code)
            f.write("\n\n")
            
            # Write the detailed conversation
            f.write("=== CONVERSATION TRANSCRIPT ===\n")
            f.write(format_conversation_for_transcript(conversation_history))
            
            # Write final result
            f.write("\n=== FINAL RESULT ===\n")
            if success:
                f.write("✓ Proper specifications achieved!\n")
                if final_code != dafny_code:
                    f.write("✓ Specifications were improved.\n")
                else:
                    f.write("✓ Original specifications were already proper.\n")
            else:
                f.write(f"❌ Failed to achieve proper specifications after {self.max_attempts} attempts\n")
                if final_code != dafny_code:
                    f.write("→ Best attempt code was saved for review.\n")
            
            f.write(f"Completed at: {time.strftime('%Y-%m-%d %H:%M:%S')}\n")
        
        # Copy to main directory for easier access
        if main_dafny_dir.exists():
            import shutil
            main_transcript_path = main_dafny_dir / "spec_validation_transcript.txt"
            shutil.copy2(transcript_path, main_transcript_path)
    
    def _parse_response(self, response_text: str) -> dict:
        """Parse the LLM response to extract specs status and code"""
        # Check for the status phrases
        has_proper_specs = "THE SCRIPT HAS PROPER SPECS" in response_text
        had_improper_specs = "THE SCRIPT HAD NOT A PROPER SPEC" in response_text
        
        if not (has_proper_specs or had_improper_specs):
            raise DafnyTranslationError("LLM response did not contain required status phrase")
        
        # Extract Dafny code
        dafny_code = ""
        code_match = re.search(r"```dafny\n(.*?)\n```", response_text, re.DOTALL)
        if code_match:
            dafny_code = code_match.group(1).strip()
        else:
            # Fallback: try to extract code without markdown
            lines = response_text.split('\n')
            code_lines = []
            in_code = False
            for line in lines:
                if 'function' in line or 'method' in line or 'ensures' in line or 'requires' in line:
                    in_code = True
                if in_code:
                    code_lines.append(line)
            dafny_code = '\n'.join(code_lines).strip()
        
        if not dafny_code:
            raise DafnyTranslationError("Could not extract Dafny code from LLM response")
        
        return {
            'has_proper_specs': has_proper_specs,
            'dafny_code': dafny_code,
            'message': "Proper specs found" if has_proper_specs else "Specs need improvement"
        } 