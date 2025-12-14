# Contributing to git-reporter

Thank you for your interest in contributing to git-reporter! This document provides guidelines and instructions for contributing.

## Getting Started

### Prerequisites

- Python 3.12 or higher
- [UV](https://github.com/astral-sh/uv) package manager
- Git

### Setting Up Your Development Environment

1. Fork the repository on GitHub

2. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/git-reporter.git
   cd git-reporter
   ```

3. Install UV if you haven't already:
   ```bash
   pip install uv
   ```

4. Install dependencies:
   ```bash
   uv sync --all-extras
   ```

5. Activate the virtual environment (optional):
   ```bash
   source .venv/bin/activate  # On Windows: .venv\Scripts\activate
   ```

## Development Workflow

### Running the CLI During Development

You can run the CLI directly using UV:

```bash
uv run git-reporter --help
uv run git-reporter init
uv run git-reporter generate --period weekly
```

### Code Style

This project uses:
- [Ruff](https://github.com/astral-sh/ruff) for linting and formatting
- Type hints for all functions
- Pydantic models for data validation

Run the linter:
```bash
uv run ruff check src/
```

Auto-fix issues:
```bash
uv run ruff check --fix src/
```

Format code:
```bash
uv run ruff format src/
```

### Project Structure

```
git-reporter/
├── src/
│   └── git_reporter/
│       ├── __init__.py          # Package initialization
│       ├── cli.py               # Command-line interface
│       ├── models.py            # Pydantic data models
│       ├── git_analyzer.py      # Git repository analysis
│       ├── report_generator.py  # Report generation
│       ├── ai/                  # AI providers
│       │   ├── base.py
│       │   ├── openai_provider.py
│       │   └── gemini_provider.py
│       └── config/              # Configuration management
│           └── manager.py
├── pyproject.toml               # Project metadata
├── README.md
├── CONTRIBUTING.md             # This file
└── PUBLISHING.md               # Publishing guide
```

## Making Changes

### Creating a Feature Branch

```bash
git checkout -b feature/your-feature-name
```

### Committing Changes

1. Make your changes
2. Test your changes thoroughly
3. Commit with a clear message:
   ```bash
   git add .
   git commit -m "Add feature: brief description"
   ```

### Submitting a Pull Request

1. Push your branch to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```

2. Go to the original repository on GitHub

3. Click "New Pull Request"

4. Select your branch and describe your changes

5. Submit the pull request

## Testing

### Manual Testing

Test the CLI commands:

```bash
# Initialize configuration
uv run git-reporter init --config /tmp/test-config.yaml

# Add a repository
uv run git-reporter add-repo --config /tmp/test-config.yaml \
    --name test-repo \
    --path /path/to/repo

# List repositories
uv run git-reporter list-repos --config /tmp/test-config.yaml

# Generate a report (requires API key)
export OPENAI_API_KEY='your-key'
uv run git-reporter generate --config /tmp/test-config.yaml --period weekly
```

### Building the Package

Test that the package builds correctly:

```bash
uv build
```

### Installing Locally

Test installation from the built package:

```bash
pip install dist/git_reporter-0.1.0-py3-none-any.whl
git-reporter --help
pip uninstall git-reporter
```

## Adding New Features

### Adding a New AI Provider

1. Create a new file in `src/git_reporter/ai/` (e.g., `claude_provider.py`)
2. Implement the `AIProvider` base class
3. Update `AIProvider` enum in `models.py`
4. Update configuration handling in `report_generator.py`
5. Add documentation in README.md

### Adding a New CLI Command

1. Add a new `@main.command()` function in `cli.py`
2. Follow the existing command patterns
3. Update README.md with the new command

### Adding Support for New Report Periods

1. Update `ReportPeriod` enum in `models.py`
2. Update `_get_date_range()` in `report_generator.py`
3. Update CLI choices in `cli.py`
4. Update documentation

## Code Review Process

All contributions go through code review:

1. Automated checks run on your PR (if CI is set up)
2. A maintainer reviews your code
3. You may be asked to make changes
4. Once approved, your PR will be merged

## Reporting Bugs

Found a bug? Please open an issue on GitHub with:

1. A clear title and description
2. Steps to reproduce
3. Expected behavior
4. Actual behavior
5. Your environment (OS, Python version, etc.)

## Suggesting Features

Have an idea? Open an issue on GitHub with:

1. A clear description of the feature
2. Why it would be useful
3. How it might work
4. Any examples or mockups

## Code of Conduct

- Be respectful and inclusive
- Welcome newcomers
- Focus on constructive feedback
- Assume good intentions

## Questions?

If you have questions, feel free to:
- Open an issue on GitHub
- Start a discussion in the repository

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

Thank you for contributing to git-reporter! 🎉
