"""Transcript generation for conversations"""

from pathlib import Path
from typing import List, Tuple, Any, Dict

from ..core.models import (
    TranslationResult, TestTranslationResult, CompilationResult,
    TestResult, VerificationResult, CompilationStatus
)
from ..utils.llm import format_conversation_for_transcript


class TranscriptWriter:
    """Handles writing conversation transcripts"""
    
    def write_solution_transcript(self, path: Path, result: TranslationResult):
        """Write solution translation transcript"""
        with open(path, 'w') as f:
            f.write(format_conversation_for_transcript(result.conversation_history))
            
    def write_test_transcript(self, path: Path, result: TestTranslationResult):
        """Write test translation transcript"""
        with open(path, 'w') as f:
            f.write(format_conversation_for_transcript(result.conversation_history))
            
    def write_summary(self, path: Path, solution_result: TranslationResult, 
                     test_result: TestTranslationResult, evaluation_results: Dict):
        """Write summary of translation and evaluation"""
        with open(path, 'w') as f:
            f.write(f"--- Solution Translation (Attempts: {solution_result.attempts}) ---\n")
            f.write(f"Input: {solution_result.input_tokens}\n")
            f.write(f"Output: {solution_result.output_tokens}\n\n")
            
            f.write(f"--- Test Translation (Attempts: {test_result.attempts}) ---\n")
            f.write(f"Input: {test_result.input_tokens}\n")
            f.write(f"Output: {test_result.output_tokens}\n\n")
            
            f.write("--- Evaluation Results ---\n")
            
            # Handle Compilation Result
            comp_result = evaluation_results.get('compilation')
            compilation_status = comp_result.status.value if isinstance(comp_result, CompilationResult) else 'unknown'
            f.write(f"Compilation: {compilation_status}\n")
            
            # Handle Test Result
            test_res = evaluation_results.get('testing')
            if isinstance(test_res, TestResult) and test_res.status != 'skipped':
                f.write(f"Testing: {test_res.passed}/{test_res.total} passed\n")
            else:
                f.write("Testing: skipped\n")
                
            # Handle Verification Result
            ver_result = evaluation_results.get('verification')
            verification_status = ver_result.status.value if isinstance(ver_result, VerificationResult) else 'skipped'
            f.write(f"Verification: {verification_status}\n")
            
    def write_dafny_outputs(self, path: Path, compilation_output: str, 
                           test_output: str, verification_output: str):
        """Write all Dafny command outputs"""
        with open(path, 'w') as f:
            f.write("=== DAFNY COMPILATION ===\n")
            f.write(compilation_output)
            f.write("\n\n")
            
            f.write("=== DAFNY TESTING ===\n")
            f.write(test_output)
            f.write("\n\n")
            
            f.write("=== DAFNY VERIFICATION ===\n")
            f.write(verification_output) 