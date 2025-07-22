"""Path manipulation utilities"""

import re
from pathlib import Path
from typing import Optional


def get_problem_id_from_dir(problem_dir: Path) -> str:
    """Extract problem ID from directory name (e.g., HumanEval_152 -> HumanEval/152)"""
    return problem_dir.name.replace('_', '/')


def get_entry_point_from_summary(summary_path: Path) -> Optional[str]:
    """Extract entry point from summary file"""
    if not summary_path.exists():
        return None
        
    with open(summary_path, 'r') as f:
        for line in f:
            if line.startswith("Entry Point:"):
                return line.split(":", 1)[1].strip()
    return None


def get_entry_point_from_code(python_code: str) -> Optional[str]:
    """Extract entry point from Python code"""
    match = re.search(r"def\s+([a-zA-Z_][a-zA-Z0-9_]*)\s*\(", python_code)
    if match:
        return match.group(1)
    return None


def get_dafny_test_file_path(problem_num: str, entry_point: str) -> Optional[Path]:
    """Find the corresponding Dafny test file"""
    dafny_tests_dir = Path("HumanEval-Dafny/tests")
    
    # Try different naming conventions
    entry_point_kebab = entry_point.replace("_", "-")
    
    candidates = [
        f"{problem_num}-{entry_point}.dfy",
        f"{problem_num}-{entry_point_kebab}.dfy"
    ]
    
    for candidate in candidates:
        path = dafny_tests_dir / candidate
        if path.exists():
            return path
            
    # Fallback: search for any file starting with the problem number
    for f in dafny_tests_dir.iterdir():
        if f.name.startswith(f"{problem_num}-"):
            return f
            
    return None


def find_run_directory(run_id: int) -> Optional[Path]:
    """Find the run directory for a given run ID"""
    runs_dir = Path("runs")
    run_id_str = str(run_id)
    
    possible_run_path = runs_dir / run_id_str
    if possible_run_path.is_dir():
        # Look for subdirectory (model name)
        subdirs = [d for d in possible_run_path.iterdir() if d.is_dir()]
        if subdirs:
            return subdirs[0]
            
    return None


def create_problem_directories(problem_dir: Path) -> dict:
    """Create all necessary directories for a problem"""
    base_dafny_dir = problem_dir / "dafny_files"
    
    # Remove existing if present
    if base_dafny_dir.exists():
        import shutil
        shutil.rmtree(base_dafny_dir)
    
    # Create directories
    dirs = {
        'base': base_dafny_dir,
        'actual': base_dafny_dir / "actual_dafny_files",
        'transcripts': base_dafny_dir / "transcripts",
        'evaluations': base_dafny_dir / "evaluations"
    }
    
    for dir_path in dirs.values():
        dir_path.mkdir(parents=True, exist_ok=True)
        
    return dirs 