# Dafny Translation Module

A modular, refactored implementation of the Python to Dafny translation pipeline.

## Architecture Overview

The module is organized into several key components:

### Core Components

- **`core/orchestrator.py`**: Main coordinator that manages the entire translation and evaluation pipeline
- **`core/models.py`**: Data models and types used throughout the module
- **`core/exceptions.py`**: Custom exception types

### Translation Components

- **`translators/base.py`**: Abstract base class for all translators
- **`translators/solution.py`**: Translates Python functions to Dafny methods
- **`translators/test.py`**: Translates Python test assertions to Dafny test methods

### Evaluation Components

- **`evaluators/compiler.py`**: Handles Dafny compilation
- **`evaluators/runner.py`**: Executes Dafny tests
- **`evaluators/verifier.py`**: Performs Dafny verification

### Utility Components

- **`utils/llm.py`**: LLM interaction utilities (code extraction, response parsing)
- **`utils/paths.py`**: Path manipulation and file discovery utilities

### Reporting Components

- **`reporting/transcript.py`**: Generates conversation transcripts
- **`reporting/visualizer.py`**: Creates visualization plots
- **`reporting/summary.py`**: Generates summary reports and categorized lists

### Configuration

- **`config/settings.py`**: Configuration management
- **`config/prompts/`**: YAML files containing LLM prompts

## Usage

### As a Module

```python
from dafny_translation import DafnyTranslationOrchestrator, Config

# Create configuration
config = Config(
    model="claude-3-5-sonnet-20240620",
    parallel_workers=10,
    api_key="your-api-key"
)

# Create orchestrator and process a run
orchestrator = DafnyTranslationOrchestrator(config)
results = orchestrator.process_run(run_id=14, max_problems=5)
```

### From Command Line

#### Full Translation and Evaluation
Using the wrapper script:
```bash
python translate_run_dafny_refactored.py 14 --model claude-3-5-sonnet-20240620 --parallel 10 --max-problems 5
```

Or as a module:
```bash
python -m dafny_translation.main 14 --model claude-3-5-sonnet-20240620 --parallel 10 --max-problems 5
```

#### Evaluation Only Mode
Skip translation and only run compilation, testing, and verification on existing Dafny files:
```bash
python -m dafny_translation.main 14 --eval-only --max-problems 5
```

This mode is useful when:
- You want to re-evaluate existing translations with different timeout settings
- You've manually fixed some Dafny files and want to check the results
- You want to get a quick overview of evaluation results without re-running expensive translations
- You want to test different evaluation configurations

#### Targeting Specific Problems
You can combine `--eval-only` with `--only` to evaluate specific problems:
```bash
python -m dafny_translation.main 14 --eval-only --only 1,5,23,45
```

## Key Improvements

1. **Separation of Concerns**: Each component has a single, well-defined responsibility
2. **Testability**: Components can be easily unit tested in isolation
3. **Extensibility**: Easy to add new translators or evaluators
4. **Configuration**: All settings and prompts are externalized
5. **Error Handling**: Proper exception hierarchy and error propagation
6. **Reusability**: Components can be used independently
7. **Evaluation Modes**: Support for both full translation+evaluation and evaluation-only workflows

## Directory Structure

```
dafny_translation/
├── __init__.py              # Module exports
├── main.py                  # CLI entry point
├── config/
│   ├── settings.py         # Configuration management
│   └── prompts/           # LLM prompt templates
│       ├── solution.yaml
│       └── test.yaml
├── core/
│   ├── orchestrator.py    # Main workflow coordinator
│   ├── models.py         # Data models
│   └── exceptions.py     # Custom exceptions
├── translators/
│   ├── base.py          # Abstract base translator
│   ├── solution.py      # Python → Dafny solution
│   └── test.py         # Python test → Dafny test
├── evaluators/
│   ├── compiler.py     # Compilation logic
│   ├── runner.py      # Test execution
│   └── verifier.py    # Verification logic
├── utils/
│   ├── llm.py        # LLM utilities
│   └── paths.py      # Path utilities
└── reporting/
    ├── transcript.py  # Conversation logs
    ├── visualizer.py # Charts/plots
    └── summary.py   # Result summaries
``` 

# Create a .env file or set environment variable:
# export ANTHROPIC_API_KEY=your_actual_api_key_here
