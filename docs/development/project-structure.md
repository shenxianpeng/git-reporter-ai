# Project Structure

Understanding the git-reporter codebase structure.

## Directory Layout

```
git-reporter/
├── .github/
│   └── workflows/        # GitHub Actions workflows
│       └── docs.yml      # Documentation deployment
├── docs/                 # Documentation source (MkDocs)
├── src/
│   └── git_reporter/
│       ├── __init__.py
│       ├── cli.py        # Command-line interface
│       ├── models.py     # Pydantic data models
│       ├── git_analyzer.py    # Git repository analysis
│       ├── report_generator.py # Report generation orchestration
│       ├── ai/           # AI provider implementations
│       │   ├── __init__.py
│       │   ├── base.py   # Base AI provider interface
│       │   ├── openai_provider.py
│       │   └── gemini_provider.py
│       └── config/       # Configuration management
│           ├── __init__.py
│           └── manager.py
├── pyproject.toml        # Project metadata and dependencies
├── mkdocs.yml           # MkDocs configuration
├── README.md
├── CONTRIBUTING.md
├── PUBLISHING.md
├── QUICKSTART.md
├── USAGE_EXAMPLES.md
├── example-config.yaml
└── LICENSE
```

## Core Components

### CLI (`cli.py`)

Command-line interface using Click. Defines all commands:
- `init` - Initialize configuration
- `add-repo` - Add repositories
- `list-repos` - List configured repos
- `generate` - Generate reports

### Models (`models.py`)

Pydantic data models for type safety and validation:
- `Config` - Main configuration
- `RepositoryConfig` - Repository settings
- `GitCommit` - Commit data
- `Report` - Generated report
- `ReportRequest` - Report generation request
- `ReportPeriod` - Time period enum
- `AIProvider` - AI provider enum

### Git Analyzer (`git_analyzer.py`)

Analyzes Git repositories:
- Handles both local and remote repositories
- Clones remote repos to temporary directories
- Extracts commit history with filtering
- Calculates commit statistics

### Report Generator (`report_generator.py`)

Orchestrates report generation:
- Coordinates git analysis
- Manages AI provider interactions
- Calculates date ranges
- Formats output

### AI Providers (`ai/`)

#### Base Provider (`base.py`)
Abstract base class defining the AI provider interface

#### OpenAI Provider (`openai_provider.py`)
OpenAI GPT implementation using pydantic-ai

#### Gemini Provider (`gemini_provider.py`)
Google Gemini implementation using pydantic-ai

### Configuration (`config/`)

Configuration file management:
- Loads YAML configuration
- Handles environment variables
- Manages config file locations
- Supports local and global configs

## Development Setup

See [Contributing Guide](contributing.md) for detailed development setup instructions.

## Technology Stack

- **UV**: Package management
- **Pydantic**: Data validation
- **Pydantic-AI**: AI model abstraction
- **GitPython**: Git operations
- **Click**: CLI framework
- **Rich**: Terminal output
- **PyYAML**: Configuration parsing

## See Also

- [Contributing](contributing.md) - Development guidelines
- [Publishing](publishing.md) - Release process
