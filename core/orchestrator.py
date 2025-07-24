"""Main orchestrator for Dafny translation"""

import re
import shutil
import traceback
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
from typing import Dict, List, Optional
from tqdm import tqdm

from ..dataset.human_eval import read_problems
from ..providers.api_providers import get_provider

from .models import (
    TranslationTask, EvaluationResult, ProblemPaths,
    CompilationStatus, CompilationResult, TestResult, VerificationResult,
    VerificationStatus, SpecValidationResult
)
from .exceptions import DafnyTranslationError, APIError
from ..config.settings import Config
from ..translators.solution import SolutionTranslator
from ..translators.test import TestTranslationResult
from ..translators.test import TestTranslator
from ..evaluators.compiler import DafnyCompiler
from ..evaluators.runner import DafnyTestRunner
from ..evaluators.verifier import DafnyVerifier
from ..evaluators.spec_validator import SpecValidator
from ..reporting.transcript import TranscriptWriter
from ..reporting.summary import Reporter
from ..utils.paths import (
    get_problem_id_from_dir, get_entry_point_from_code,
    find_run_directory, create_problem_directories
)


class DafnyTranslationOrchestrator:
    """Orchestrates the entire Dafny translation process"""
    
    def __init__(self, config: Config):
        self.config = config
        
        # Initialize translators only if not in eval-only mode
        if not config.eval_only:
            # Initialize provider
            ProviderClass = get_provider(config.provider)
            self.provider = ProviderClass(api_key=config.api_key)
            
            # Initialize translators
            self.solution_translator = SolutionTranslator(self.provider, config.model, config)
            self.test_translator = TestTranslator(self.provider, config.model, config)
        else:
            self.provider = None
            self.solution_translator = None
            self.test_translator = None
        
        # Initialize evaluators (always needed)
        self.compiler = DafnyCompiler(config.dafny_path, config.compilation_timeout)
        self.test_runner = DafnyTestRunner(config.dafny_path, config.test_timeout)
        self.verifier = DafnyVerifier(config.dafny_path, config.verification_timeout)
        
        # Initialize spec validator if needed
        if config.validate_specs and not config.eval_only:
            # Need provider for spec validation
            if not self.provider:
                ProviderClass = get_provider(config.provider)
                self.provider = ProviderClass(api_key=config.api_key)
            self.spec_validator = SpecValidator(self.provider, config.model, config)
        elif config.validate_specs and config.eval_only:
            # For eval-only mode with spec validation, still need provider
            ProviderClass = get_provider(config.provider)
            provider = ProviderClass(api_key=config.api_key)
            self.spec_validator = SpecValidator(provider, config.model, config)
        else:
            self.spec_validator = None
        
        # Initialize reporters
        self.transcript_writer = TranscriptWriter()
        self.reporter = Reporter(config)
        
    def process_run(self, run_id: int, max_problems: Optional[int] = None, only: Optional[str] = None) -> List[EvaluationResult]:
        """Process an entire HumanEval run"""
        # Find run directory
        run_path = find_run_directory(run_id)
        if not run_path:
            raise DafnyTranslationError(f"Could not find run directory for run ID {run_id}")
            
        print(f"\n{'='*60}")
        print(f"Processing run {run_id} from {run_path}")
        if self.config.eval_only:
            print("Mode: EVALUATION ONLY (skipping translation)")
        else:
            print(f"Model: {self.config.model}")
        print(f"Parallel workers: {self.config.parallel_workers}")
        print(f"{'='*60}\n")
        
        # Get problem directories
        problems = read_problems()
        
        if self.config.eval_only:
            # In eval-only mode, look for problems with existing Dafny files
            problem_dirs = [
                d for d in run_path.iterdir() 
                if d.is_dir() and self._has_existing_dafny_files(d)
            ]
        else:
            # In normal mode, look for problems with Python solutions
            problem_dirs = [
                d for d in run_path.iterdir() 
                if d.is_dir() and (d / "model_solution.py").exists()
            ]
        
        # Sort for consistent ordering
        problem_dirs.sort(key=lambda p: int(p.name.split('_')[1]))
        
        # Filter by specific problems if --only flag is used
        if only:
            try:
                only_numbers = [int(x.strip()) for x in only.split(',')]
                # Validate that all numbers are non-negative
                if any(num < 0 for num in only_numbers):
                    raise DafnyTranslationError("Problem numbers must be non-negative")
                    
                problem_dirs = [
                    d for d in problem_dirs 
                    if int(d.name.split('_')[1]) in only_numbers
                ]
                print(f"Filtering to only problems: {only_numbers}")
                print(f"Found {len(problem_dirs)} matching problems")
                
                # Warn about missing problems
                found_numbers = [int(d.name.split('_')[1]) for d in problem_dirs]
                missing_numbers = [num for num in only_numbers if num not in found_numbers]
                if missing_numbers:
                    print(f"Warning: The following problems were not found in the run: {missing_numbers}")
                    
            except ValueError as e:
                raise DafnyTranslationError(f"Invalid format for --only parameter. Use comma-separated numbers (e.g., --only 34,14,51): {e}")
        
        # Limit problems if requested (after filtering by --only)
        if max_problems and len(problem_dirs) > max_problems:
            print(f"Limiting to the first {max_problems} problems")
            problem_dirs = problem_dirs[:max_problems]
            
        if self.config.eval_only:
            print(f"Found {len(problem_dirs)} problems with existing Dafny files to evaluate")
        
        # Process problems in parallel
        results = self._process_problems_parallel(problem_dirs, problems)
        
        # Generate summary
        self.reporter.generate_summary(results, run_path, run_id, self.config.model)
        
        return results
    
    def _has_existing_dafny_files(self, problem_dir: Path) -> bool:
        """Check if a problem has existing Dafny files"""
        paths = ProblemPaths.from_problem_dir(problem_dir)
        return (paths.dafny_solution_path.exists() and 
                paths.dafny_test_path.exists())
        
    def _process_problems_parallel(self, problem_dirs: List[Path], 
                                  problems: Dict) -> List[EvaluationResult]:
        """Process problems in parallel"""
        results_by_problem = {}
        
        mode_str = "evaluation" if self.config.eval_only else "translation and evaluation"
        model_str = f" using {self.config.model}" if not self.config.eval_only else ""
        print(f"Starting Dafny {mode_str}{model_str}...")
        
        with ThreadPoolExecutor(max_workers=self.config.parallel_workers) as executor:
            futures = {}
            
            for p_dir in problem_dirs:
                task_id = get_problem_id_from_dir(p_dir)
                if task_id in problems:
                    problem = problems[task_id]
                    if self.config.eval_only:
                        future = executor.submit(self._process_single_problem_eval_only, p_dir, problem)
                    else:
                        future = executor.submit(self._process_single_problem, p_dir, problem)
                    futures[future] = p_dir.name
                    
            progress_desc = f"Evaluating" if self.config.eval_only else f"Processing ({self.config.model})"
            for future in tqdm(as_completed(futures), total=len(futures), desc=progress_desc):
                problem_name = futures[future]
                try:
                    result = future.result()
                    if result is None:
                        if self.config.debug:
                            tqdm.write(f"\n{'='*20} WORKER FAILED (SILENTLY) {'='*20}")
                            tqdm.write(f"Problem: {problem_name}")
                            tqdm.write("The worker process returned no result.")
                            tqdm.write(f"{'='*60}\n")
                        results_by_problem[problem_name] = EvaluationResult(
                            problem_id=problem_name,
                            compilation=CompilationResult(status=CompilationStatus.ERROR),
                            error_message="Worker failed silently"
                        )
                    else:
                        results_by_problem[problem_name] = result
                except Exception as e:
                    # Make sure crashes are NOT silent - print to console immediately
                    tqdm.write(f"\n{'='*20} WORKER CRASHED {'='*20}")
                    tqdm.write(f"Problem: {problem_name}")
                    tqdm.write(f"Exception: {type(e).__name__}: {e}")
                    tqdm.write("Traceback:")
                    tqdm.write(traceback.format_exc())
                    tqdm.write(f"{'='*55}\n")
                    
                    # Store detailed error information for later reporting
                    full_error_details = f"WORKER CRASH - {type(e).__name__}: {e}\n\nFull Traceback:\n{traceback.format_exc()}"
                    
                    results_by_problem[problem_name] = EvaluationResult(
                        problem_id=problem_name,
                        compilation=CompilationResult(status=CompilationStatus.ERROR),
                        error_message=full_error_details
                    )
                    
        return list(results_by_problem.values())
    
    def _process_single_problem_eval_only(self, problem_dir: Path, problem: dict) -> EvaluationResult:
        """Process a single problem in evaluation-only mode"""
        problem_name = problem_dir.name
        self._log_debug(f"[{problem_name}] Starting evaluation-only processing.")
        
        import time
        start_time = time.time()
        
        try:
            # Setup paths
            self._log_debug(f"[{problem_name}] Setting up paths...")
            paths = ProblemPaths.from_problem_dir(problem_dir)
            
            # For spec validation, clean only leftover artifacts from previous runs
            if self.config.validate_specs:
                import shutil
                # Clean only leftover spec validation files, keep original solution.dfy and test.dfy
                leftover_files = [
                    "old_spec_solution.dfy",
                    "new_spec_solution.dfy", 
                    "base_spec_solution.dfy",
                    "solution_new_spec.dfy",
                    "solution_in_dafny.dfy"
                ]
                
                for filename in leftover_files:
                    leftover_path = paths.actual_dafny_files_dir / filename
                    if leftover_path.exists():
                        leftover_path.unlink()
                        
                # Clean evaluation directory if it exists
                if paths.evaluations_dir.exists():
                    shutil.rmtree(paths.evaluations_dir)
                
                self._log_debug(f"[{problem_name}] Cleaned leftover spec validation artifacts...")
            
            # Check if Dafny files exist
            if not paths.dafny_solution_path.exists():
                raise DafnyTranslationError(f"Solution file not found: {paths.dafny_solution_path}")
            if not paths.dafny_test_path.exists():
                raise DafnyTranslationError(f"Test file not found: {paths.dafny_test_path}")
            
            # Read existing Dafny files
            self._log_debug(f"[{problem_name}] Reading existing Dafny files...")
            solution_code = paths.dafny_solution_path.read_text()
            full_test_code = paths.dafny_test_path.read_text()
            
            # Extract only the test methods from the test file
            # The test file contains both a dummy method and the actual test methods
            # We need to extract only the test methods for evaluation
            test_code = self._extract_test_methods(full_test_code)
            
            # Read Python code if spec validation is enabled
            python_code = None
            if self.config.validate_specs and paths.solution_path.exists():
                python_code = paths.solution_path.read_text()
            
            # Create directory for evaluation outputs if it doesn't exist
            if not paths.evaluations_dir.exists():
                paths.evaluations_dir.mkdir(parents=True, exist_ok=True)
            
            # Evaluate
            self._log_debug(f"[{problem_name}] Starting evaluation...")
            eval_start = time.time()
            eval_results = self._evaluate(
                solution_code,
                test_code,
                paths.evaluations_dir,
                python_code
            )
            eval_time = time.time() - eval_start
            self._log_debug(f"[{problem_name}] Evaluation took {eval_time:.2f} seconds")
            
            # Create evaluation result without translation results
            self._log_debug(f"[{problem_name}] Creating evaluation result...")
            eval_result = EvaluationResult(
                problem_id=problem_name,  # Use problem_name directly instead of task.problem_id
                compilation=eval_results['compilation'],
                testing=eval_results.get('testing'),
                verification=eval_results.get('verification'),
                solution_result=None,  # No translation was performed
                test_result=None,      # No translation was performed
                spec_validation=eval_results.get('spec_validation')
            )

            # Write tldr summary (simplified for eval-only mode)
            self._log_debug(f"[{problem_name}] Writing summary...")
            if not paths.transcripts_dir.exists():
                paths.transcripts_dir.mkdir(parents=True, exist_ok=True)
            self.reporter.write_tldr_summary(
                paths.transcripts_dir / "tldr.txt",
                eval_result,
                self.config.max_tokens
            )

            total_time = time.time() - start_time
            self._log_debug(f"[{problem_name}] Finished evaluation-only processing in {total_time:.2f} seconds.")
            return eval_result
            
        except (DafnyTranslationError, FileNotFoundError) as e:
            self._log_debug(f"[{problem_name}] Known error: {type(e).__name__}: {e}")
            error_details = f"Known Error - {type(e).__name__}: {e}"
            return EvaluationResult(
                problem_id=problem_dir.name,
                compilation=CompilationResult(status=CompilationStatus.ERROR),
                error_message=error_details
            )
        except Exception as e:
            # Capture the current step context for better debugging
            import sys
            tb = traceback.format_exc()
            error_details = f"Unexpected Error - {type(e).__name__}: {e}\n\nFull Traceback:\n{tb}"
            
            self._log_error(problem_name, e, tb)
            return EvaluationResult(
                problem_id=problem_dir.name,
                compilation=CompilationResult(status=CompilationStatus.ERROR),
                error_message=error_details
            )
        
    def _extract_test_methods(self, full_test_code: str) -> str:
        """Extract only test methods from a test file, removing any dummy method implementations"""
        lines = full_test_code.split('\n')
        result_lines = []
        in_dummy_method = False
        brace_count = 0
        
        for i, line in enumerate(lines):
            stripped = line.strip()
            
            # Check if we're starting a method that's NOT a test method
            if not in_dummy_method and 'method' in line and '{:test}' not in line:
                in_dummy_method = True
                brace_count = 0
                # Don't include this line in output
                continue
            
            if in_dummy_method:
                # Count braces to track method boundaries
                open_braces = line.count('{')
                close_braces = line.count('}')
                brace_count += open_braces - close_braces
                
                # If we've closed all braces, we're done with the dummy method
                if brace_count == 0 and (open_braces > 0 or close_braces > 0):
                    in_dummy_method = False
                # Don't include dummy method lines in output
                continue
            
            # Include all other lines (test methods, empty lines, etc.)
            result_lines.append(line)
        
        # Join and clean up - remove excessive leading/trailing empty lines
        result = '\n'.join(result_lines)
        return result.strip()
        
    def _process_single_problem(self, problem_dir: Path, problem: dict) -> EvaluationResult:
        """Process a single problem"""
        problem_name = problem_dir.name
        self._log_debug(f"[{problem_name}] Starting processing with {self.config.model}.")
        
        try:
            # Create task
            self._log_debug(f"[{problem_name}] Creating task...")
            task = self._create_task(problem_dir, problem)
            
            # Setup paths
            self._log_debug(f"[{problem_name}] Setting up paths...")
            paths = ProblemPaths.from_problem_dir(problem_dir)
            dirs = create_problem_directories(problem_dir)
            
            # Translate solution
            self._log_debug(f"[{problem_name}] Translating solution...")
            solution_result = self.solution_translator.translate(
                task, paths.evaluations_dir
            )

            if solution_result.max_tokens_exceeded:
                self._log_warning(f"[{problem_name}] Solution translation failed by running out of tokens.")
            
            # Write solution
            self._log_debug(f"[{problem_name}] Writing solution files...")
            paths.dafny_solution_path.write_text(solution_result.dafny_code)
            self.transcript_writer.write_solution_transcript(
                paths.transcripts_dir / "solution_transcript.txt",
                solution_result
            )
            
            # Translate tests
            self._log_debug(f"[{problem_name}] Translating tests...")
            test_result = self.test_translator.translate(
                task, solution_result, paths.evaluations_dir
            )
            
            if test_result.max_tokens_exceeded:
                self._log_warning(f"[{problem_name}] Test translation failed by running out of tokens.")

            # Write tests
            self._log_debug(f"[{problem_name}] Writing test files...")
            test_code = f"{test_result.dummy_method}\n\n{test_result.dafny_code}"
            paths.dafny_test_path.write_text(test_code)
            self.transcript_writer.write_test_transcript(
                paths.transcripts_dir / "test_transcript.txt",
                test_result
            )
            
            # Evaluate
            self._log_debug(f"[{problem_name}] Starting evaluation...")
            eval_results = self._evaluate(
                solution_result.dafny_code,
                test_result.dafny_code,
                paths.evaluations_dir,
                task.python_code if self.config.validate_specs else None
            )
            
            self._log_debug(f"[{problem_name}] Creating evaluation result...")
            eval_result = self._create_evaluation_result(
                task, solution_result, test_result, eval_results
            )

            # Write tldr summary
            self._log_debug(f"[{problem_name}] Writing summary...")
            self.reporter.write_tldr_summary(
                paths.transcripts_dir / "tldr.txt",
                eval_result,
                self.config.max_tokens
            )

            self._log_debug(f"[{problem_name}] Finished processing.")
            return eval_result
            
        except (DafnyTranslationError, APIError, FileNotFoundError) as e:
            self._log_debug(f"[{problem_name}] Known error: {type(e).__name__}: {e}")
            error_details = f"Known Error - {type(e).__name__}: {e}"
            return EvaluationResult(
                problem_id=problem_dir.name,
                compilation=CompilationResult(status=CompilationStatus.ERROR),
                error_message=error_details
            )
        except Exception as e:
            # Capture the current step context for better debugging
            import sys
            tb = traceback.format_exc()
            error_details = f"Unexpected Error - {type(e).__name__}: {e}\n\nFull Traceback:\n{tb}"
            
            self._log_error(problem_name, e, tb)
            return EvaluationResult(
                problem_id=problem_dir.name,
                compilation=CompilationResult(status=CompilationStatus.ERROR),
                error_message=error_details
            )

    def _create_evaluation_result(self, task: TranslationTask, 
                                solution_result, test_result, eval_results) -> EvaluationResult:
        """Create an EvaluationResult from all the components"""
        return EvaluationResult(
            problem_id=task.problem_id,
            compilation=eval_results['compilation'],
            testing=eval_results.get('testing'),
            verification=eval_results.get('verification'),
            solution_result=solution_result,
            test_result=test_result,
            spec_validation=eval_results.get('spec_validation')
        )

    def _create_task(self, problem_dir: Path, problem: dict) -> TranslationTask:
        """Create a translation task from problem data"""
        # Read files
        solution_path = problem_dir / "model_solution.py"
        problem_statement_path = problem_dir / "problem_statement.txt"
        
        with open(solution_path, 'r') as f:
            python_code = f.read()
        with open(problem_statement_path, 'r') as f:
            problem_statement = f.read()
            
        # Extract entry point from code
        entry_point = get_entry_point_from_code(python_code)
        if not entry_point:
            raise DafnyTranslationError(f"Could not find function definition in {solution_path}")
            
        # Override problem entry point with extracted one
        problem['entry_point'] = entry_point
        
        return TranslationTask(
            problem_id=problem_dir.name,
            problem_dir=problem_dir,
            entry_point=entry_point,
            python_code=python_code,
            test_code=problem['test'],
            problem_statement=problem_statement,
            problem_data=problem
        )
        
    def _evaluate(self, solution_code: str, test_code: str, 
                 evaluations_dir: Path, python_code: Optional[str] = None) -> Dict:
        """Run Dafny evaluation"""
        import time
        results = {}
        outputs_path = evaluations_dir / "dafny_outputs.txt"
        
        with open(outputs_path, 'w') as f:
            # Compilation
            f.write("=== DAFNY COMPILATION ===\n")
            full_code = f"{solution_code}\n\n{test_code}"
            # Don't create temp_eval.dfy here - let the compiler create its own temp file
            
            compile_start = time.time()
            compile_result = self.compiler.compile(full_code, evaluations_dir)
            compile_time = time.time() - compile_start
            self._log_debug(f"  Compilation took {compile_time:.2f} seconds")
            
            f.write(f"COMMAND: dafny build --no-verify --allow-warnings temp_compile.dfy\n")
            f.write(f"Return code: {compile_result.returncode}\n")
            f.write(f"STDOUT:\n{compile_result.stdout}\n")
            f.write(f"STDERR:\n{compile_result.stderr}\n")
            f.write(f"Compilation result: {compile_result.status.value}\n\n")
            
            results['compilation'] = compile_result
            
            # Testing (if compilation passed)
            if compile_result.status == CompilationStatus.PASSED:
                f.write("=== DAFNY TESTING ===\n")
                test_start = time.time()
                test_result = self.test_runner.run_tests(full_code, evaluations_dir)
                test_time = time.time() - test_start
                self._log_debug(f"  Testing took {test_time:.2f} seconds")
                
                f.write(f"COMMAND: dafny test --no-verify temp_test.dfy\n")
                f.write(f"Return code: {test_result.returncode}\n")
                f.write(f"STDOUT:\n{test_result.stdout}\n")
                f.write(f"STDERR:\n{test_result.stderr}\n")
                f.write(f"Testing result: {test_result.passed}/{test_result.total} passed\n\n")
                
                results['testing'] = test_result
                
                # Verification (if all tests passed)
                if test_result.total > 0 and test_result.passed == test_result.total and not self.config.skip_verification:
                    f.write("=== DAFNY VERIFICATION ===\n")
                    paths = ProblemPaths.from_problem_dir(evaluations_dir.parent.parent)
                    f.write(f"VERIFYING: {paths.dafny_solution_path}\n")
                    
                    verify_start = time.time()
                    verify_result = self.verifier.verify(solution_code, evaluations_dir)
                    verify_time = time.time() - verify_start
                    self._log_debug(f"  Verification took {verify_time:.2f} seconds")
                    
                    f.write(f"COMMAND: dafny verify {paths.dafny_solution_path.name}\n")
                    f.write(f"Return code: {verify_result.returncode}\n")
                    f.write(f"STDOUT:\n{verify_result.stdout}\n")
                    f.write(f"STDERR:\n{verify_result.stderr}\n")
                    f.write(f"Verification result: {verify_result.status.value}\n")
                    
                    results['verification'] = verify_result
                else:
                    results['verification'] = VerificationResult(status=VerificationStatus.SKIPPED)
                    if self.config.skip_verification:
                        f.write("=== DAFNY VERIFICATION ===\nSkipped due to --skip-verification flag.\n")
                    else:
                        f.write("=== DAFNY VERIFICATION ===\nSkipped due to failing tests.\n")
            else:
                results['testing'] = TestResult(passed=0, total=0, status="skipped")
                results['verification'] = VerificationResult(status=VerificationStatus.SKIPPED)
                f.write("=== DAFNY TESTING ===\nSkipped due to compilation failure.\n")
                f.write("=== DAFNY VERIFICATION ===\nSkipped due to compilation failure.\n")
            
            # Specification validation (if enabled and compilation passed)
            if (self.config.validate_specs and self.spec_validator and 
                python_code and results.get('compilation') and 
                results['compilation'].status == CompilationStatus.PASSED):
                
                f.write("=== SPEC VALIDATION ===\n")
                spec_start = time.time()
                
                try:
                    spec_result = self.spec_validator.validate_and_improve_specs(
                        python_code, solution_code, evaluations_dir
                    )
                    spec_time = time.time() - spec_start
                    self._log_debug(f"  Spec validation took {spec_time:.2f} seconds")
                    
                    f.write(f"Spec validation attempts: {spec_result.attempts}\n")
                    f.write(f"Has proper specs: {spec_result.has_proper_specs}\n")
                    for msg in spec_result.validation_messages:
                        f.write(f"- {msg}\n")
                    
                    results['spec_validation'] = spec_result
                    
                    # Note: Improved code is now saved automatically by spec validator
                    # as solution_new_spec.dfy if different from original
                    
                except Exception as e:
                    self._log_warning(f"Spec validation failed: {e}")
                    f.write(f"Spec validation failed: {e}\n")
                    results['spec_validation'] = None
            elif self.config.validate_specs and self.spec_validator and python_code:
                f.write("=== SPEC VALIDATION ===\nSkipped (compilation failed)\n")
                results['spec_validation'] = None
        
        return results
    
    def _log_debug(self, message: str):
        """Log debug message if debug mode is enabled"""
        if self.config.debug:
            print(message)
            
    def _log_warning(self, message: str):
        """Log warning message"""
        print(f"WARNING: {message}")
        
    def _log_error(self, problem_name: str, exception: Exception, traceback_str: str):
        """Log error details"""
        print(f"\nERROR in {problem_name}: {type(exception).__name__}: {exception}")
        if self.config.debug:
            print(f"Traceback:\n{traceback_str}") 