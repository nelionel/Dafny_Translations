"""Abstract base class for translators"""

from abc import ABC, abstractmethod
from typing import Dict, Any, Tuple, Optional
import re
import yaml
from pathlib import Path
import anthropic

from ..core.models import TranslationResult, CompilationResult, CompilationStatus
from ..core.exceptions import TranslationError, APIError
from ..evaluators.compiler import DafnyCompiler
from ..utils.llm import extract_code_from_response


class BaseTranslator(ABC):
    """Abstract base class for all translators"""
    
    def __init__(self, provider, model: str, config):
        self.provider = provider
        self.model = model
        self.config = config
        self.max_retries = config.max_retries
        self.max_tokens = config.max_tokens
        self.compiler = DafnyCompiler(config.dafny_path, config.compilation_timeout)
        
    @abstractmethod
    def get_prompt_template(self) -> Dict[str, str]:
        """Load and return the prompt template"""
        pass
        
    @abstractmethod
    def format_prompt(self, template: Dict[str, str], **kwargs) -> Tuple[str, str]:
        """Format the prompt template with provided values"""
        pass
        
    @abstractmethod
    def extract_code(self, response) -> str:
        """Extract Dafny code from LLM response"""
        pass
        
    def compile_check(self, code: str, work_dir: Path) -> Tuple[bool, str]:
        """Check if generated code compiles"""
        result = self.compiler.compile(code, work_dir, verify=False)
        return result.status == CompilationStatus.PASSED, result.stderr or result.stdout
        
    def translate_with_retries(self, messages, system_prompt: str, work_dir: Path) -> TranslationResult:
        """Perform translation with retry logic"""
        # Validate inputs
        if not system_prompt or system_prompt.isspace():
            raise TranslationError("System prompt cannot be empty")
        if not messages or not messages[0].get("content") or messages[0]["content"].isspace():
            raise TranslationError("Initial user message cannot be empty")
            
        conversation_history = []
        input_tokens = 0
        output_tokens = 0
        attempts = 0
        code = ""
        compilation_error = ""
        max_tokens_exceeded = False
        
        # Add system prompt and initial user message to conversation
        conversation_history.append(("system", system_prompt))
        conversation_history.append(("user", messages[0]["content"]))
        
        for attempt in range(self.max_retries + 1):
            attempts = attempt + 1
            
            if attempt > 0:
                # Add correction prompt
                correction_prompt = self._get_correction_prompt(compilation_error)
                # Validate correction prompt is not empty
                if not correction_prompt or correction_prompt.isspace():
                    # If we can't generate a meaningful correction prompt, stop retrying
                    break
                messages.append({"role": "user", "content": correction_prompt})
                conversation_history.append(("user", correction_prompt))
                
            try:
                # Call LLM
                response = self._call_llm(system_prompt, messages)
                
                # Store current response for subclasses to access
                self._current_response = response
                
                # Add to conversation history
                # Convert structured response content to plain text for next iteration
                response_text = ""
                if hasattr(response, 'content') and isinstance(response.content, list):
                    # Extract text from all text blocks
                    text_parts = []
                    for block in response.content:
                        if hasattr(block, 'type') and block.type == 'text' and hasattr(block, 'text'):
                            if block.text and not block.text.isspace():  # Only add non-empty text
                                text_parts.append(block.text)
                    response_text = "\n".join(text_parts)
                else:
                    response_text = str(response.content)
                
                # Ensure we don't add empty content
                if not response_text or response_text.isspace():
                    response_text = "[Assistant response contained no text content]"
                
                messages.append({"role": "assistant", "content": response_text})
                conversation_history.append(("assistant", response.content))  # Keep original for transcript
                
                # Extract code
                code = self.extract_code(response)
                
                # Update token counts
                input_tokens += response.usage.input_tokens
                output_tokens += response.usage.output_tokens
                
                # Check for token limit
                if response.stop_reason == "max_tokens":
                    max_tokens_exceeded = True
                
            except anthropic.BadRequestError as e:
                raise APIError(f"API BadRequestError: {e.response.text}")
            except Exception as e:
                raise TranslationError(f"API call failed on attempt {attempt}: {e}")
                
            # Check compilation
            if self._should_check_compilation():
                success, error = self.compile_check(code, work_dir)
                if success:
                    break
                compilation_error = error
                
                # If no error output, we can't retry
                if not compilation_error or compilation_error.isspace():
                    break
            else:
                # No compilation check needed
                break
                
        return TranslationResult(
            dafny_code=code,
            attempts=attempts,
            input_tokens=input_tokens,
            output_tokens=output_tokens,
            conversation_history=conversation_history,
            compilation_error=compilation_error if compilation_error else None,
            max_tokens_exceeded=max_tokens_exceeded
        )
        
    def _call_llm(self, system_prompt: str, messages):
        """Call the LLM API"""
        # Additional validation before making API call
        for i, message in enumerate(messages):
            content = message.get("content", "")
            # Handle both string content and structured content
            if isinstance(content, str):
                if not content or content.isspace():
                    raise TranslationError(f"Message {i} has empty string content. This would cause an API error.")
            elif isinstance(content, list):
                # For structured content, check if ANY text blocks are empty
                text_blocks = []
                for block in content:
                    if isinstance(block, dict) and block.get('type') == 'text':
                        text_blocks.append(block.get('text', ''))
                
                if not text_blocks:
                    raise TranslationError(f"Message {i} has no text content blocks. This would cause an API error.")
                
                # Check if any text block is empty (not all - any single empty block causes API failure)
                for idx, text in enumerate(text_blocks):
                    if not text or text.isspace():
                        # Include more debugging information
                        block_info = f"text block {idx} in message {i}"
                        raise TranslationError(f"Message {i} has empty content blocks ({block_info}). This would cause an API error.")
            else:
                # For other content types, convert to string and check
                content_str = str(content)
                if not content_str or content_str.isspace():
                    raise TranslationError(f"Message {i} has empty content (type: {type(content)}). This would cause an API error.")
        
        try:
            return self.provider.create_message(
                model=self.model,
                system_prompt=system_prompt,
                messages=messages,
                max_tokens=self.max_tokens
            )
        except Exception as e:
            error_text = str(e)
            if "text content blocks must be non-empty" in error_text:
                raise APIError("Empty content block detected in API request. This indicates a bug in message construction.")
            raise  # Re-raise other exceptions as-is
        
    def _get_correction_prompt(self, error: str) -> str:
        """Get the correction prompt template"""
        # Validate error input
        if not error or error.isspace():
            return ""  # Return empty string to trigger retry termination
            
        template = self.get_prompt_template()
        correction_template = template.get('correction', '')
        
        if not correction_template or correction_template.isspace():
            # Fallback correction prompt if template is missing
            correction_template = """
Your previous attempt failed to compile. Here is the error message:
<compilation_error>
{compilation_error}
</compilation_error>

Please analyze the error and provide the COMPLETE corrected code.
"""
        
        try:
            return correction_template.format(compilation_error=error)
        except (KeyError, ValueError) as e:
            # If template formatting fails, return a basic correction prompt
            return f"Your previous attempt failed with error: {error}. Please provide a corrected version."
        
    def _should_check_compilation(self) -> bool:
        """Whether to check compilation for this translator"""
        return True
        
    def load_prompt_from_file(self, filename: str) -> Dict[str, str]:
        """Load prompt template from YAML file"""
        prompt_path = Path(__file__).parent.parent / "config" / "prompts" / filename
        with open(prompt_path, 'r') as f:
            return yaml.safe_load(f) 