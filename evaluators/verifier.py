"""Dafny verification logic"""

import subprocess
import re
from pathlib import Path

from ..core.models import VerificationResult, VerificationStatus


class DafnyVerifier:
    """Handles Dafny verification"""
    
    def __init__(self, dafny_path: str, timeout: int = 100):
        self.dafny_path = dafny_path
        self.timeout = timeout
        
    def verify(self, code: str, work_dir: Path) -> VerificationResult:
        """Verify Dafny code"""
        # Write code to temporary file
        temp_file = work_dir / "temp_verify.dfy"
        temp_file.write_text(code)
        
        # Build command
        cmd = [self.dafny_path, "verify", str(temp_file.name)]
        
        try:
            # Run verification
            proc = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                cwd=work_dir,
                timeout=self.timeout
            )
            
            # Clean up
            temp_file.unlink(missing_ok=True)
            
            # Check for successful verification
            verification_match = re.search(r"(\d+)\s+verified,\s+0\s+errors", proc.stdout)
            if verification_match:
                status = VerificationStatus.PASSED
            else:
                status = VerificationStatus.FAILED
                
            return VerificationResult(
                status=status,
                stdout=proc.stdout,
                stderr=proc.stderr,
                returncode=proc.returncode
            )
            
        except subprocess.TimeoutExpired as e:
            # Clean up
            temp_file.unlink(missing_ok=True)
            
            return VerificationResult(
                status=VerificationStatus.TIMEOUT,
                stdout=e.stdout or "",
                stderr=e.stderr or "",
                returncode=None
            )
            
        except Exception as e:
            # Clean up
            temp_file.unlink(missing_ok=True)
            
            return VerificationResult(
                status=VerificationStatus.FAILED,
                stdout="",
                stderr=str(e),
                returncode=None
            )
            
    def verify_file(self, file_path: Path) -> VerificationResult:
        """Verify a Dafny file"""
        # Build command
        cmd = [self.dafny_path, "verify", file_path.name]
        
        try:
            # Run verification
            proc = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                cwd=file_path.parent,
                timeout=self.timeout
            )
            
            # Check for successful verification
            verification_match = re.search(r"(\d+)\s+verified,\s+0\s+errors", proc.stdout)
            if verification_match:
                status = VerificationStatus.PASSED
            else:
                status = VerificationStatus.FAILED
                
            return VerificationResult(
                status=status,
                stdout=proc.stdout,
                stderr=proc.stderr,
                returncode=proc.returncode
            )
            
        except subprocess.TimeoutExpired as e:
            return VerificationResult(
                status=VerificationStatus.TIMEOUT,
                stdout=e.stdout or "",
                stderr=e.stderr or "",
                returncode=None
            )
            
        except Exception as e:
            return VerificationResult(
                status=VerificationStatus.FAILED,
                stdout="",
                stderr=str(e),
                returncode=None
            ) 