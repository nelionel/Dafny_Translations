"""Data models for Dafny translation"""

from dataclasses import dataclass, field
from typing import Dict, List, Optional, Tuple, Any
from pathlib import Path
from enum import Enum


class CompilationStatus(Enum):
    PASSED = "passed"
    FAILED = "failed"
    TIMEOUT = "timeout"
    ERROR = "error"
    SKIPPED = "skipped"


class VerificationStatus(Enum):
    PASSED = "passed"
    FAILED = "failed"
    TIMEOUT = "timeout"
    SKIPPED = "skipped"


@dataclass
class TranslationTask:
    """Represents a single problem to translate"""
    problem_id: str
    problem_dir: Path
    entry_point: str
    python_code: str
    test_code: str
    problem_statement: str
    problem_data: Dict[str, Any]  # Full problem data from HumanEval
    

@dataclass
class TranslationResult:
    """Represents the result of a single translation attempt"""
    dafny_code: str
    attempts: int
    input_tokens: int
    output_tokens: int
    conversation_history: List[Tuple[str, Any]]
    compilation_error: Optional[str] = None
    max_tokens_exceeded: bool = False
    

@dataclass
class TestTranslationResult(TranslationResult):
    """Result of translating tests, includes dummy method"""
    dummy_method: str = ""
    

@dataclass
class CompilationResult:
    """Result of Dafny compilation"""
    status: CompilationStatus
    stdout: str = ""
    stderr: str = ""
    returncode: Optional[int] = None
    

@dataclass
class TestResult:
    """Result of running Dafny tests"""
    passed: int = 0
    total: int = 0
    stdout: str = ""
    stderr: str = ""
    returncode: Optional[int] = None
    status: str = "completed"
    

@dataclass
class VerificationResult:
    """Result of Dafny verification"""
    status: VerificationStatus
    stdout: str = ""
    stderr: str = ""
    returncode: Optional[int] = None
    

@dataclass
class SpecValidationResult:
    """Result of specification validation"""
    has_proper_specs: bool
    improved_code: str
    attempts: int
    validation_messages: List[str]


@dataclass
class EvaluationResult:
    """Complete evaluation results for a problem"""
    problem_id: str
    compilation: CompilationResult
    testing: Optional[TestResult] = None
    verification: Optional[VerificationResult] = None
    solution_result: Optional[TranslationResult] = None
    test_result: Optional[TestTranslationResult] = None
    spec_validation: Optional[SpecValidationResult] = None
    error_message: Optional[str] = None
    

@dataclass
class ProblemPaths:
    """All paths related to a problem"""
    problem_dir: Path
    solution_path: Path
    problem_statement_path: Path
    base_dafny_dir: Path
    actual_dafny_files_dir: Path
    transcripts_dir: Path
    evaluations_dir: Path
    dafny_solution_path: Path
    dafny_test_path: Path
    
    @classmethod
    def from_problem_dir(cls, problem_dir: Path) -> 'ProblemPaths':
        """Create all paths from a problem directory"""
        base_dafny_dir = problem_dir / "dafny_files"
        actual_dafny_files_dir = base_dafny_dir / "actual_dafny_files"
        transcripts_dir = base_dafny_dir / "transcripts"
        evaluations_dir = base_dafny_dir / "evaluations"
        
        return cls(
            problem_dir=problem_dir,
            solution_path=problem_dir / "model_solution.py",
            problem_statement_path=problem_dir / "problem_statement.txt",
            base_dafny_dir=base_dafny_dir,
            actual_dafny_files_dir=actual_dafny_files_dir,
            transcripts_dir=transcripts_dir,
            evaluations_dir=evaluations_dir,
            dafny_solution_path=actual_dafny_files_dir / "solution.dfy",
            dafny_test_path=actual_dafny_files_dir / "test.dfy"
        ) 