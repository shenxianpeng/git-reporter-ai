# git-reporter

AI-Powered Git Commit History Analyzer and Report Generator

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.12+](https://img.shields.io/badge/python-3.12+-blue.svg)](https://www.python.org/downloads/)

## Overview

`git-reporter` is a powerful Python tool that analyzes your Git commit history across multiple repositories and uses AI to generate professional work reports. Perfect for developers who need to create weekly, monthly, quarterly, or yearly reports for their managers without maintaining daily logs.

## Features

- 📊 **Multi-Repository Analysis**: Analyze commits from multiple Git repositories simultaneously
- 🤖 **AI-Powered Reports**: Generate intelligent summaries using OpenAI GPT or Google Gemini
- ⏰ **Flexible Time Periods**: Support for daily, weekly, monthly, quarterly, yearly, and custom date ranges
- 🎯 **Author Filtering**: Filter commits by specific author email addresses
- 🔧 **Easy Configuration**: Simple YAML-based configuration
- 🎨 **Rich CLI Interface**: Beautiful command-line interface with progress indicators
- 📝 **Export Reports**: Save reports to markdown files
- 🔒 **Secure**: API keys stored in environment variables, not in config files

## Technologies Used

- **UV**: Modern Python package manager for fast dependency management
- **Pydantic**: Data validation using Python type annotations
- **Pydantic-AI**: AI model abstraction layer for easy integration with multiple providers
- **GitPython**: Git repository interaction
- **Click**: Command-line interface creation
- **Rich**: Beautiful terminal output

## Installation

### From PyPI (Once Published)

```bash
pip install git-reporter
```

### From Source

```bash
# Clone the repository
git clone https://github.com/shenxianpeng/git-reporter.git
cd git-reporter

# Install UV if you haven't already
pip install uv

# Install the package
uv sync
```

## Quick Start

### 1. Initialize Configuration

```bash
git-reporter init
```

This creates a configuration file at `~/.git-reporter/config.yaml`.

### 2. Add Repositories

```bash
git-reporter add-repo --name "my-project" --path "/path/to/repo" --email "your@email.com"
git-reporter add-repo --name "another-project" --path "/path/to/another/repo"
```

### 3. Set Up API Keys

Set your AI provider API key as an environment variable:

```bash
# For OpenAI
export OPENAI_API_KEY='your-openai-api-key'

# Or for Google Gemini
export GEMINI_API_KEY='your-gemini-api-key'
```

### 4. Generate a Report

```bash
# Generate a weekly report (default)
git-reporter generate

# Generate a monthly report
git-reporter generate --period monthly

# Generate a custom period report
git-reporter generate --period custom --start 2024-01-01 --end 2024-12-31

# Save report to file
git-reporter generate --period weekly --output report.md
```

## Configuration

The configuration file is located at `~/.git-reporter/config.yaml`. Here's an example:

```yaml
ai_provider: openai  # or 'gemini'
default_period: weekly
openai_model: gpt-4o-mini
gemini_model: gemini-2.0-flash-exp
repositories:
  - name: my-project
    path: /home/user/projects/my-project
    author_email: developer@example.com
  - name: another-project
    path: /home/user/projects/another-project
    author_email: developer@example.com
```

### Configuration Options

- `ai_provider`: AI provider to use (`openai` or `gemini`)
- `default_period`: Default report period (`daily`, `weekly`, `monthly`, `quarterly`, `yearly`)
- `openai_model`: OpenAI model to use (default: `gpt-4o-mini`)
- `gemini_model`: Gemini model to use (default: `gemini-2.0-flash-exp`)
- `repositories`: List of repositories to analyze
  - `name`: Repository identifier
  - `path`: Local path to the Git repository
  - `author_email`: (Optional) Filter commits by this author email

## CLI Commands

### `git-reporter init`

Initialize a new configuration file.

Options:
- `--config`, `-c`: Custom configuration file path

### `git-reporter add-repo`

Add a repository to the configuration.

Options:
- `--name`, `-n`: Repository name (required)
- `--path`, `-p`: Local path to repository (required)
- `--email`, `-e`: Filter commits by author email (optional)
- `--config`, `-c`: Custom configuration file path

### `git-reporter list-repos`

List all configured repositories.

Options:
- `--config`, `-c`: Custom configuration file path

### `git-reporter generate`

Generate a report from Git commit history.

Options:
- `--period`, `-p`: Report period (`daily`, `weekly`, `monthly`, `quarterly`, `yearly`, `custom`)
- `--start`, `-s`: Start date for custom period (YYYY-MM-DD)
- `--end`, `-e`: End date for custom period (YYYY-MM-DD)
- `--repo`, `-r`: Specific repositories to include (can be used multiple times)
- `--output`, `-o`: Output file path
- `--provider`: AI provider to use (overrides config)
- `--config`, `-c`: Custom configuration file path

## Examples

### Generate a Weekly Report

```bash
git-reporter generate --period weekly
```

### Generate a Monthly Report for Specific Repositories

```bash
git-reporter generate --period monthly --repo my-project --repo another-project
```

### Generate a Custom Period Report and Save to File

```bash
git-reporter generate --period custom --start 2024-01-01 --end 2024-03-31 --output Q1-2024-report.md
```

### Use Different AI Provider

```bash
git-reporter generate --period weekly --provider gemini
```

## AI Providers

### OpenAI

Supports models like:
- `gpt-4o` (most capable)
- `gpt-4o-mini` (faster and cheaper, default)
- `gpt-4-turbo`
- `gpt-3.5-turbo`

Get your API key from [OpenAI Platform](https://platform.openai.com/).

### Google Gemini

Supports models like:
- `gemini-2.0-flash-exp` (fastest, default)
- `gemini-1.5-pro`
- `gemini-1.5-flash`

Get your API key from [Google AI Studio](https://aistudio.google.com/).

## Development

### Setting Up Development Environment

```bash
# Clone the repository
git clone https://github.com/shenxianpeng/git-reporter.git
cd git-reporter

# Install UV
pip install uv

# Install dependencies including dev dependencies
uv sync --all-extras

# Run tests (when available)
uv run pytest

# Run linter
uv run ruff check src/
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
│       ├── report_generator.py  # Report generation orchestration
│       ├── ai/                  # AI providers
│       │   ├── __init__.py
│       │   ├── base.py          # Base AI provider interface
│       │   ├── openai_provider.py
│       │   └── gemini_provider.py
│       └── config/              # Configuration management
│           ├── __init__.py
│           └── manager.py
├── pyproject.toml               # Project metadata and dependencies
├── README.md                    # This file
└── LICENSE                      # MIT License
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built with [UV](https://github.com/astral-sh/uv) for fast dependency management
- Powered by [Pydantic-AI](https://github.com/pydantic/pydantic-ai) for AI model abstraction
- Uses [GitPython](https://github.com/gitpython-developers/GitPython) for Git operations
- Beautiful CLI with [Rich](https://github.com/Textualize/rich)

## Support

If you encounter any issues or have questions, please [open an issue](https://github.com/shenxianpeng/git-reporter/issues) on GitHub.

## Roadmap

- [ ] Add support for more AI providers (Anthropic Claude, etc.)
- [ ] Add web interface
- [ ] Support for team reports (multiple authors)
- [ ] Integration with project management tools (Jira, GitHub Issues)
- [ ] Custom report templates
- [ ] Report comparison and trends over time
- [ ] Email report delivery
- [ ] Docker container support
