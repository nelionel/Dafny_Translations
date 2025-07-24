# Dafny Translation Framework

A comprehensive framework for automatically translating HumanEval Python problems to formally verified Dafny code.

## Overview

This framework provides a complete pipeline for:
- **Translation**: Python → Dafny (solutions and tests)
- **Evaluation**: Compilation, testing, and verification
- **Specification Validation**: Iterative improvement of formal specifications
- **Reporting**: Comprehensive visualizations and summaries

## Features

- ✅ **Fully self-contained module** - includes data, code, and runs
- ✅ **Parallel processing** with configurable workers
- ✅ **Retry logic** with compilation feedback for translation improvement
- ✅ **Spec validation** with fresh conversations for unbiased evaluation
- ✅ **Comprehensive evaluation** (compile → test → verify → validate specs)
- ✅ **Rich reporting** with visualizations and categorized summaries
- ✅ **Two execution modes**: Full translation vs. Eval-only
- ✅ **Token tracking** and usage limits

## Quick Start

### Requirements

1. **Python 3.8+** with pip
2. **Dafny** installed and accessible (default: `/opt/homebrew/bin/dafny`)
3. **API Key**: Set `ANTHROPIC_API_KEY` environment variable

### Installation

```bash
# Install Python dependencies (use pip3 if you have both Python 2 and 3)
pip install -r Dafny_Translations/requirements.txt
# OR if you need to specify Python 3 explicitly:
pip3 install -r Dafny_Translations/requirements.txt

# Set API key
export ANTHROPIC_API_KEY=your_key_here
```

### Usage

#### Start Small: Test with a Few Problems

Before running the full evaluation, it's recommended to test with a small number of problems to verify everything works correctly:

```bash
# Test with just 5 problems (evaluation only, using existing translations)
python -m Dafny_Translations.main 10 --eval-only --max-problems 5
# OR if you need to specify Python 3:
python3 -m Dafny_Translations.main 10 --eval-only --max-problems 5
```

**What to expect after running this test:**
- **Terminal output**: You'll see a progress bar and summary statistics (compilation rate, test passing rate, verification rate)
- **Generated files**: Look in `Dafny_Translations/runs/10/claude-sonnet-4-20250514/` for:
  - `dafny_evaluation_summary.png` - Visual summary of results
  - `dafny_summary/compiled.txt` - List of successfully compiled problems
  - `dafny_summary/tested.txt` - Test results summary
  - `dafny_summary/verified.txt` - Formal verification results

#### Full Evaluation

Once you've verified the small test works, run the complete evaluation:

```bash
# Evaluate all 164 existing translations
python -m Dafny_Translations.main 10 --eval-only
# OR with Python 3:
python3 -m Dafny_Translations.main 10 --eval-only
```

#### Generate New Translations

To create new Dafny translations from Python problems:

```bash
# Full translation pipeline for a new run (start with a few problems)
python -m Dafny_Translations.main 11 --max-problems 5
# OR with Python 3:
python3 -m Dafny_Translations.main 11 --max-problems 5

# Full translation pipeline (all problems)
python -m Dafny_Translations.main 11
# OR with Python 3:
python3 -m Dafny_Translations.main 11

# With specification validation (more thorough but slower)
python -m Dafny_Translations.main 11 --validate-specs
# OR with Python 3:
python3 -m Dafny_Translations.main 11 --validate-specs
```

#### Advanced Configuration

```bash
# Custom settings example
python -m Dafny_Translations.main 11 \
    --parallel 3 \
    --max-retries 5 \
    --max-problems 10 \
    --validate-specs
# OR with Python 3:
python3 -m Dafny_Translations.main 11 \
    --parallel 3 \
    --max-retries 5 \
    --max-problems 10 \
    --validate-specs
```

**Command Options:**
- `--eval-only`: Skip translation, only evaluate existing Dafny files
- `--max-problems N`: Limit to first N problems (useful for testing)
- `--parallel N`: Number of parallel workers (default: 5)
- `--max-retries N`: Maximum retry attempts for translations
- `--validate-specs`: Include specification validation (slower but more thorough)

## Data Structure

The framework is **completely self-contained** with internal data:

```
Dafny_Translations/
├── runs/                       # 🎯 INTERNAL RUN DATA
│   ├── 10/
│   │   └── claude-sonnet-4-20250514/
│   │       ├── HumanEval_0/
│   │       │   ├── model_solution.py
│   │       │   ├── problem_statement.txt
│   │       │   └── tests.py
│   │       ├── HumanEval_1/
│   │       └── ...
│   ├── 11/
│   └── 12/
├── dataset/                    # HumanEval problem definitions
├── providers/                  # API abstraction
├── core/                       # Main logic
├── translators/               # Translation components
├── evaluators/                # Evaluation components
├── reporting/                 # Visualization & summaries
├── config/                    # Settings & prompts
├── utils/                     # Helper functions
└── ...
```

## Architecture

### Core Components
- **`main.py`** - CLI entry point
- **`core/orchestrator.py`** - Main pipeline controller  
- **`core/models.py`** - Data structures
- **`translators/`** - Python → Dafny translation logic
- **`evaluators/`** - Compilation, testing, verification, spec validation
- **`reporting/`** - Summary generation and visualizations

### Internal Dependencies
- **`providers/`** - API abstraction layer (Anthropic)
- **`dataset/`** - HumanEval problem data utilities
- **`config/`** - Settings and prompt templates
- **`utils/`** - Helper functions
- **`runs/`** - 🎯 **RUN DATA STORAGE**

## Configuration

Key settings in `config/settings.py`:
- **Model**: `claude-sonnet-4-20250514` (locked)
- **Max retries**: 3 (unified for translation + spec validation)
- **Max tokens**: 16,384
- **Thinking budget**: 6,000 tokens
- **Parallel workers**: 5
- **Timeouts**: 100s each for compilation/testing/verification

## Output Structure

```
Dafny_Translations/runs/{run_id}/{model}/HumanEval_X/dafny_files/
├── actual_dafny_files/
│   ├── solution.dfy              # Final/improved solution
│   ├── test.dfy                  # Test methods + dummy
│   └── old_spec_solution.dfy     # Original before improvement
├── transcripts/
│   ├── solution_transcript.txt   # Translation conversation
│   ├── test_transcript.txt       # Test translation
│   ├── spec_validation_transcript.txt
│   └── tldr.txt                  # Summary with token usage
└── evaluations/
    └── dafny_outputs.txt         # Compilation/test logs
```

## Pipeline Logic

### Translation Mode
1. **Solution Translation** (cumulative context with retry logic)
2. **Test Translation** (cumulative context with retry logic)  
3. **Evaluation**: Compile → Test → Verify
4. **Optional**: Spec Validation (fresh conversation each attempt)

### Eval-Only Mode  
1. **Read existing** `solution.dfy` + `test.dfy` files from internal storage
2. **Evaluation**: Compile → Test → Verify
3. **Optional**: Spec Validation (fresh conversation each attempt)

## Key Design Features

### Translation Retries (Cumulative Context)
- Conversation grows across attempts for iterative refinement
- Compilation errors inform next translation attempt
- Debugging mindset - learn from previous failures

### Spec Validation Retries (Fresh Context)  
- New conversation each attempt with improved code
- Independent evaluation prevents contamination
- Unbiased perspective on specification quality

## Portability

The module is **100% self-contained**:
- ✅ **No external dependencies** beyond Python packages
- ✅ **Internal data storage** in `runs/` directory
- ✅ **All logic contained** within the module
- ✅ **Portable anywhere** - just copy the directory

For development, all configuration, prompts, data, and logic are contained within the module structure.
