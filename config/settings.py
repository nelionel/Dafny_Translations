"""Configuration settings for Dafny translation"""

from dataclasses import dataclass
from pathlib import Path
from typing import Optional
import os


@dataclass
class Config:
    """Configuration for Dafny translation"""
    # Dafny settings
    dafny_path: str = "/opt/homebrew/bin/dafny"
    compilation_timeout: int = 100
    test_timeout: int = 100
    verification_timeout: int = 100
    
    # Translation settings
    max_retries: int = 3
    max_tokens: int = 16384  # Doubled again from 8192
    model: str = "claude-sonnet-4-20250514"  # Updated default model
    
    # Parallel execution
    parallel_workers: int = 5  # Reduced from 10 to 5 for better speed/stability balance
    
    # API settings
    api_key: Optional[str] = None  # Set via environment variable ANTHROPIC_API_KEY
    provider: str = "anthropic"
    
    # Thinking budget for Claude
    thinking_budget_tokens: int = 6000  # Doubled from 3000
    temperature: float = 1.0

    # Debugging
    debug: bool = False
    
    # Evaluation mode
    eval_only: bool = False
    skip_verification: bool = False
    
    # Specification validation
    validate_specs: bool = False
    
    def __post_init__(self):
        """Validate and set defaults"""
        # The key is now hardcoded, but we keep this structure for future flexibility
        if not self.api_key:
            self.api_key = os.environ.get("ANTHROPIC_API_KEY")
        
        # Expand paths
        self.dafny_path = os.path.expanduser(self.dafny_path)
    
    @classmethod
    def from_args(cls, args):
        """Create config from command line arguments"""
        config = cls()
        
        # Map all CLI arguments to config attributes
        if hasattr(args, 'api_key') and args.api_key:
            config.api_key = args.api_key
        if hasattr(args, 'model') and args.model:
            config.model = args.model
        if hasattr(args, 'parallel') and args.parallel:
            config.parallel_workers = args.parallel
        if hasattr(args, 'max_retries') and args.max_retries is not None:
            config.max_retries = args.max_retries
        if hasattr(args, 'max_tokens') and args.max_tokens is not None:
            config.max_tokens = args.max_tokens
        if hasattr(args, 'compilation_timeout') and args.compilation_timeout is not None:
            config.compilation_timeout = args.compilation_timeout
        if hasattr(args, 'test_timeout') and args.test_timeout is not None:
            config.test_timeout = args.test_timeout
        if hasattr(args, 'verification_timeout') and args.verification_timeout is not None:
            config.verification_timeout = args.verification_timeout
        if hasattr(args, 'thinking_budget') and args.thinking_budget is not None:
            config.thinking_budget_tokens = args.thinking_budget
        if hasattr(args, 'debug') and args.debug:
            config.debug = args.debug
        if hasattr(args, 'eval_only') and args.eval_only:
            config.eval_only = args.eval_only
        if hasattr(args, 'skip_verification') and args.skip_verification:
            config.skip_verification = args.skip_verification
        if hasattr(args, 'validate_specs') and args.validate_specs:
            config.validate_specs = args.validate_specs
            
        return config 