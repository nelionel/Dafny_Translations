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
# Install Python dependencies
pip install -r dafny_translation/requirements.txt

# Set API key
export ANTHROPIC_API_KEY=your_key_here
```

### Usage

```bash
# Full translation pipeline
python3 -m dafny_translation.main <run_id>

# Evaluation only (skip translation)
python3 -m dafny_translation.main <run_id> --eval-only

# With specification validation
python3 -m dafny_translation.main <run_id> --validate-specs

# Advanced usage
python3 -m dafny_translation.main <run_id> \
    --parallel 3 \
    --max-retries 5 \
    --max-problems 10 \
    --validate-specs
```

## Data Structure

The framework is **completely self-contained** with internal data:

```
dafny_translation/
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
dafny_translation/runs/{run_id}/{model}/HumanEval_X/dafny_files/
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
