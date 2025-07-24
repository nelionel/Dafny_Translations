"""
HumanEval dataset utilities
"""
from typing import Iterable, Dict
import gzip
import json
import os
from pathlib import Path


def read_problems(evalset_file: str = None) -> Dict[str, Dict]:
    """
    Read HumanEval problems from jsonl file.
    If no file specified, looks for HumanEval.jsonl.gz in the dataset directory.
    """
    if evalset_file is None:
        # Look for the data file in the same directory as this module
        current_dir = Path(__file__).parent
        evalset_file = current_dir / "HumanEval.jsonl.gz"
        
        # If not found, try alternative locations
        if not evalset_file.exists():
            # Try parent directory data folder (original location)
            parent_data = current_dir.parent.parent / "human-eval" / "data" / "HumanEval.jsonl.gz"
            if parent_data.exists():
                evalset_file = str(parent_data)
            else:
                raise FileNotFoundError(
                    f"Could not find HumanEval.jsonl.gz in {evalset_file} or {parent_data}. "
                    "Please ensure the dataset file is available."
                )
        else:
            evalset_file = str(evalset_file)
    
    return {task["task_id"]: task for task in stream_jsonl(evalset_file)}


def stream_jsonl(filename: str) -> Iterable[Dict]:
    """
    Parses each jsonl line and yields it as a dictionary
    """
    if filename.endswith(".gz"):
        with open(filename, "rb") as gzfp:
            with gzip.open(gzfp, 'rt') as fp:
                for line in fp:
                    if any(not x.isspace() for x in line):
                        yield json.loads(line)
    else:
        with open(filename, "r") as fp:
            for line in fp:
                if any(not x.isspace() for x in line):
                    yield json.loads(line)


def write_jsonl(filename: str, data: Iterable[Dict], append: bool = False):
    """
    Writes an iterable of dictionaries to jsonl
    """
    if append:
        mode = 'ab'
    else:
        mode = 'wb'
    filename = os.path.expanduser(filename)
    if filename.endswith(".gz"):
        with open(filename, mode) as fp:
            with gzip.GzipFile(fileobj=fp, mode='wb') as gzfp:
                for x in data:
                    gzfp.write((json.dumps(x) + "\n").encode('utf-8'))
    else:
        with open(filename, mode) as fp:
            for x in data:
                fp.write((json.dumps(x) + "\n").encode('utf-8')) 