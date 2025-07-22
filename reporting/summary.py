"""Summary generation for results"""

from pathlib import Path
from typing import List, Dict

from ..core.models import EvaluationResult, CompilationStatus, VerificationStatus
from .visualizer import Visualizer


class Reporter:
    """Generates summary reports"""
    
    def __init__(self, config):
        self.config = config
        self.visualizer = Visualizer()
        
    def generate_summary(self, results: List[EvaluationResult], run_path: Path, 
                        run_id: int, model: str):
        """Generate complete summary including files and plots"""
        # Generate main summary plot
        plot_path = run_path / "dafny_evaluation_summary.png"
        stats = self.visualizer.generate_summary_plot(results, plot_path, run_id, model)
        
        # Generate additional visualizations if translation data is available
        translation_results = [r for r in results if r.solution_result and r.test_result]
        if translation_results:
            # Generate attempt distribution histograms
            self.visualizer.generate_attempts_histograms(results, run_path, run_id, model)
            
            # Generate success vs attempts plot
            self.visualizer.generate_success_vs_attempts_plot(results, run_path, run_id, model)
        
        # Print summary
        print("\n--- Aggregate Results ---")
        print(f"Total problems processed: {stats['total_problems']}")
        print(f"Compilation rate: {stats['compilation_rate']:.2f}%")
        print(f"Test passing rate: {stats['test_pass_rate']:.2f}% ({stats['passed_tests']}/{stats['total_tests']})")
        print(f"Verification rate: {stats['verification_rate']:.2f}%")
        
        # Print spec validation results if available
        if stats.get('spec_validated_count', 0) > 0:
            print(f"Proper specification rate: {stats['spec_validation_rate']:.2f}% ({stats['good_specs_count']}/{stats['spec_validated_count']})")
        
        # Create summary files
        self._create_summary_files(results, run_path)
        
    def _create_summary_files(self, results: List[EvaluationResult], run_path: Path):
        """Create categorized summary files"""
        # Initialize lists
        compiled_problems = []
        tested_problems = []
        verified_problems = []
        failed_compilation_problems = []
        failed_testing_problems = []
        detailed_errors = []  # For full error details
        
        # Additional lists for spec validation
        good_spec_problems = []
        bad_spec_problems = []
        
        # Categorize results
        for result in results:
            problem_name = result.problem_id
            
            # Handle spec validation results
            if result.spec_validation:
                if result.spec_validation.has_proper_specs:
                    good_spec_problems.append(problem_name)
                else:
                    bad_spec_problems.append(problem_name)
            
            if result.error_message:
                # Show detailed error information instead of generic "(worker_error)"
                error_summary = result.error_message.split('\n')[0]  # First line of error
                if len(error_summary) > 300:  # Increase limit to show more detail
                    error_summary = error_summary[:297] + "..."
                failed_compilation_problems.append(f"{problem_name} ({error_summary})")
                
                # Store full error details for detailed log
                detailed_errors.append(f"=== {problem_name} ===\n{result.error_message}\n")
                continue
                
            if result.compilation.status == CompilationStatus.PASSED:
                compiled_problems.append(problem_name)
                
                if result.testing:
                    if result.testing.total > 0 and result.testing.passed == result.testing.total:
                        tested_problems.append(problem_name)
                    elif result.testing.total > 0:
                        failed_testing_problems.append(
                            f"{problem_name} ({result.testing.passed}/{result.testing.total})"
                        )
                        
                if result.verification and result.verification.status == VerificationStatus.PASSED:
                    verified_problems.append(problem_name)
            else:
                failed_compilation_problems.append(
                    f"{problem_name} ({result.compilation.status.value})"
                )
                
        # Create summary directory
        summary_dir = run_path / "dafny_summary"
        summary_dir.mkdir(exist_ok=True)
        
        # Write files
        self._write_list_file(summary_dir / "compiled.txt", compiled_problems, "Compilation")
        self._write_list_file(summary_dir / "tested.txt", tested_problems, "Test")
        self._write_list_file(summary_dir / "verified.txt", verified_problems, "Verification")
        self._write_list_file(summary_dir / "failed_compilation.txt", 
                             failed_compilation_problems, "Compilation failure")
        self._write_list_file(summary_dir / "failed_testing.txt", 
                             failed_testing_problems, "Test failure")
        if detailed_errors:
            with open(summary_dir / "detailed_errors.txt", 'w') as f:
                f.write("\n".join(detailed_errors))
            print("Detailed error log saved to detailed_errors.txt")
        
        # Write spec validation files if spec validation was enabled
        if good_spec_problems or bad_spec_problems:
            self._write_list_file(summary_dir / "good_spec.txt", 
                                 good_spec_problems, "Good specifications")
            self._write_list_file(summary_dir / "bad_spec.txt", 
                                 bad_spec_problems, "Bad specifications")
                             
    def _write_list_file(self, path: Path, items: List[str], category: str):
        """Write a sorted list to file"""
        with open(path, 'w') as f:
            f.write("\n".join(sorted(items)))
        print(f"{category} summary saved to {path.name}") 

    def write_tldr_summary(self, path: Path, result: EvaluationResult, max_tokens: int):
        """Write a TLDR summary for a single problem"""
        with open(path, 'w') as f:
            if result.solution_result:
                solution_attempts = result.solution_result.attempts
                solution_input = result.solution_result.input_tokens
                solution_output = result.solution_result.output_tokens
                f.write(f"--- Solution Translation (Attempts: {solution_attempts}) ---\n")
                f.write(f"Input: {solution_input}\n")
                f.write(f"Output: {solution_output} / {max_tokens}\n\n")
            else:
                f.write("--- Solution Translation (Attempts: 0) ---\n")
                f.write("Input: 0\n")
                f.write(f"Output: 0 / {max_tokens}\n\n")

            if result.test_result:
                test_attempts = result.test_result.attempts
                test_input = result.test_result.input_tokens
                test_output = result.test_result.output_tokens
                f.write(f"--- Test Translation (Attempts: {test_attempts}) ---\n")
                f.write(f"Input: {test_input}\n")
                f.write(f"Output: {test_output} / {max_tokens}\n\n")
            else:
                f.write("--- Test Translation (Attempts: 0) ---\n")
                f.write("Input: 0\n")
                f.write(f"Output: 0 / {max_tokens}\n\n")
            
            f.write("--- Evaluation Results ---\n")
            compilation_status = result.compilation.status.value
            f.write(f"Compilation: {compilation_status}\n")
            if result.compilation.stderr:
                f.write(f"Compilation Error: {result.compilation.stderr}\n")

            if result.testing:
                f.write(f"Testing: {result.testing.passed}/{result.testing.total} passed\n")
            else:
                f.write("Testing: skipped\n")

            if result.verification:
                f.write(f"Verification: {result.verification.status.value}\n")
            else:
                f.write("Verification: skipped\n")

            if result.error_message:
                f.write(f"Overall Error: {result.error_message}\n") 