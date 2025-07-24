"""Main entry point for Dafny translation"""

import argparse
import sys
import time
from pathlib import Path

from .core.orchestrator import DafnyTranslationOrchestrator
from .config.settings import Config
from .core.exceptions import DafnyTranslationError


def main():
    """Main entry point with CLI"""
    parser = argparse.ArgumentParser(
        description="Translate and evaluate a full HumanEval run to Dafny."
    )
    parser.add_argument(
        "run_id", 
        type=int, 
        help="The ID of the HumanEval run to process."
    )
    parser.add_argument(
        "--api-key",
        type=str,
        default=None,
        help="Anthropic API key. If not provided, it will be read from the ANTHROPIC_API_KEY environment variable."
    )
    parser.add_argument(
        "--model", 
        type=str, 
        default="claude-sonnet-4-20250514",
        help="The Claude model to use for translation (default: claude-sonnet-4-20250514)."
    )
    parser.add_argument(
        "--parallel", 
        type=int, 
        default=5,
        help="Number of parallel workers (default: 5)."
    )
    parser.add_argument(
        "--max-problems", 
        type=int, 
        default=None,
        help="Limit the number of problems to process for a quicker run."
    )
    parser.add_argument(
        "--only",
        type=str,
        default=None,
        help="Run only specific problems by number. Provide a comma-separated list (e.g., --only 34,14,51,325)."
    )
    parser.add_argument(
        "--eval-only",
        action="store_true",
        help="Skip translation and only run evaluation (compilation, testing, verification) on existing Dafny files. "
             "Note: Each problem takes ~10 seconds due to Dafny startup overhead. Consider using --parallel 2 or 3 to avoid system overload."
    )
    parser.add_argument(
        "--skip-verification",
        action="store_true",
        help="Skip the verification step during evaluation to speed up processing. Useful for quick compilation and test checks."
    )
    parser.add_argument(
        "--max-retries",
        type=int,
        default=3,
        help="Maximum number of retries for failed translations and spec validation attempts (default: 3)."
    )
    parser.add_argument(
        "--max-tokens",
        type=int,
        default=16384,
        help="Maximum tokens for LLM responses (default: 16384)."
    )
    parser.add_argument(
        "--compilation-timeout",
        type=int,
        default=100,
        help="Timeout in seconds for Dafny compilation (default: 100)."
    )
    parser.add_argument(
        "--test-timeout",
        type=int,
        default=100,
        help="Timeout in seconds for Dafny test execution (default: 100)."
    )
    parser.add_argument(
        "--verification-timeout",
        type=int,
        default=100,
        help="Timeout in seconds for Dafny verification (default: 100)."
    )
    parser.add_argument(
        "--thinking-budget",
        type=int,
        default=6000,
        help="Token budget for Claude's thinking process (default: 6000)."
    )
    parser.add_argument(
        "--debug",
        action="store_true",
        help="Enable detailed, per-problem logging to the console."
    )
    parser.add_argument(
        "--validate-specs",
        action="store_true",
        help="Validate and improve Dafny specifications for problems that compile and pass tests. "
             "Works with existing Dafny files (compatible with --eval-only)."
    )
    
    args = parser.parse_args()
    
    # Create config from arguments
    config = Config.from_args(args)
    
    # Validate API key only if not in eval-only mode
    if not config.eval_only and not config.api_key:
        print("Please set the ANTHROPIC_API_KEY environment variable or provide the --api-key flag.")
        sys.exit(1)
        
    # Display configuration
    print(f"\n{'='*60}")
    print("DAFNY TRANSLATION CONFIGURATION")
    print(f"{'='*60}")
    print(f"Run ID: {args.run_id}")
    if config.eval_only:
        mode_text = "EVALUATION ONLY (skipping translation)"
        if config.validate_specs:
            mode_text += " + SPEC VALIDATION"
        print(f"Mode: {mode_text}")
    else:
        mode_text = f"Model: {config.model}"
        if config.validate_specs:
            mode_text += " + SPEC VALIDATION"
        print(mode_text)
        print(f"Parallel workers: {config.parallel_workers}")
        print(f"Max retries per problem: {config.max_retries}")
        print(f"Max tokens: {config.max_tokens}")
        print(f"Thinking budget: {config.thinking_budget_tokens} tokens")
    if args.max_problems:
        print(f"Max problems: {args.max_problems}")
    if args.only:
        print(f"Only problems: {args.only}")
    print(f"{'='*60}\n")
        
    try:
        # Create orchestrator and process run
        orchestrator = DafnyTranslationOrchestrator(config)
        orchestrator.process_run(args.run_id, args.max_problems, args.only)
        
    except DafnyTranslationError as e:
        print(f"Error: {e}")
        sys.exit(1)
    except KeyboardInterrupt:
        print("\nInterrupted by user")
        sys.exit(1)
    except Exception as e:
        print(f"Unexpected error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main() 