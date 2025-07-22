"""Dafny test execution logic"""

import subprocess
import re
from pathlib import Path

from ..core.models import TestResult


class DafnyTestRunner:
    """Handles Dafny test execution"""
    
    def __init__(self, dafny_path: str, timeout: int = 100):
        self.dafny_path = dafny_path
        self.timeout = timeout
        
    def run_tests(self, code: str, work_dir: Path) -> TestResult:
        """Run Dafny tests"""
        # Write code to temporary file
        temp_file = work_dir / "temp_test.dfy"
        temp_file.write_text(code)
        
        # Build command
        cmd = [self.dafny_path, "test", "--no-verify", str(temp_file.name)]
        
        try:
            # Run tests
            proc = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                cwd=work_dir,
                timeout=self.timeout
            )
            
            # Clean up
            temp_file.unlink(missing_ok=True)
            
            # Parse results
            full_output = proc.stdout + "\n" + proc.stderr
            passed, total = self._parse_test_output(full_output)
            
            return TestResult(
                passed=passed,
                total=total,
                stdout=proc.stdout,
                stderr=proc.stderr,
                returncode=proc.returncode,
                status="completed"
            )
            
        except subprocess.TimeoutExpired as e:
            # Clean up
            temp_file.unlink(missing_ok=True)
            
            return TestResult(
                passed=0,
                total=0,
                stdout=e.stdout or "",
                stderr=e.stderr or "",
                returncode=None,
                status="timeout"
            )
            
        except Exception as e:
            # Clean up
            temp_file.unlink(missing_ok=True)
            
            return TestResult(
                passed=0,
                total=0,
                stdout="",
                stderr=str(e),
                returncode=None,
                status="error"
            )
            
    def run_test_file(self, file_path: Path) -> TestResult:
        """Run tests in a Dafny file"""
        # Build command
        cmd = [self.dafny_path, "test", "--no-verify", file_path.name]
        
        try:
            # Run tests
            proc = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                cwd=file_path.parent,
                timeout=self.timeout
            )
            
            # Parse results
            full_output = proc.stdout + "\n" + proc.stderr
            passed, total = self._parse_test_output(full_output)
            
            return TestResult(
                passed=passed,
                total=total,
                stdout=proc.stdout,
                stderr=proc.stderr,
                returncode=proc.returncode,
                status="completed"
            )
            
        except subprocess.TimeoutExpired as e:
            return TestResult(
                passed=0,
                total=0,
                stdout=e.stdout or "",
                stderr=e.stderr or "",
                returncode=None,
                status="timeout"
            )
            
        except Exception as e:
            return TestResult(
                passed=0,
                total=0,
                stdout="",
                stderr=str(e),
                returncode=None,
                status="error"
            )
            
    def _parse_test_output(self, output: str) -> tuple[int, int]:
        """Parse test output to extract passed/total counts"""
        # Strategy 1: Look for the "Test summary" line
        summary_match = re.search(r"Test summary:\s*(\d+)\s*tests,\s*(\d+)\s*passed", output)
        if summary_match:
            total_tests = int(summary_match.group(1))
            passed_tests = int(summary_match.group(2))
            return passed_tests, total_tests
            
        # Strategy 2: Count PASSED/FAILED lines
        passed_tests = len(re.findall(r"PASSED", output))
        failed_tests = len(re.findall(r"FAILED", output))
        total_tests = passed_tests + failed_tests
        
        return passed_tests, total_tests 