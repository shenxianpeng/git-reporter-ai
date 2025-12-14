# Installation

Get git-reporter installed on your system with multiple installation options.

## Prerequisites

- Python 3.12 or higher
- pip (Python package installer)
- Git

## Installation Methods

### Method 1: Install from PyPI (Recommended)

Once published to PyPI, you can install git-reporter with a single command:

```bash
pip install git-reporter
```

### Method 2: Install with UV (Recommended for Developers)

[UV](https://github.com/astral-sh/uv) is a fast Python package manager. Install UV first:

```bash
pip install uv
```

Then install git-reporter:

```bash
uv pip install git-reporter
```

### Method 3: Install from Source

For the latest development version or to contribute:

```bash
# Clone the repository
git clone https://github.com/shenxianpeng/git-reporter.git
cd git-reporter

# Install with UV (recommended)
uv sync

# Or install with pip
pip install -e .
```

### Method 4: Using pipx (Isolated Installation)

Install git-reporter in an isolated environment:

```bash
# Install pipx if you haven't already
pip install pipx

# Install git-reporter
pipx install git-reporter
```

## Verify Installation

Check that git-reporter is installed correctly:

```bash
git-reporter --version
```

You should see the version number displayed.

## Next Steps

After installation, proceed to:

1. [Quick Start Guide](quickstart.md) - Get started in 5 minutes
2. [Configuration](configuration.md) - Set up your repositories and AI provider
3. [CLI Commands](../user-guide/cli-commands.md) - Learn all available commands

## Troubleshooting

### Command not found

If you get a "command not found" error after installation:

1. **Check your PATH**: Make sure Python's script directory is in your PATH
   ```bash
   # On Linux/Mac
   export PATH="$HOME/.local/bin:$PATH"
   
   # On Windows (PowerShell)
   $env:Path += ";$HOME\AppData\Roaming\Python\Scripts"
   ```

2. **Reinstall with user flag**:
   ```bash
   pip install --user git-reporter
   ```

### Python version mismatch

If you encounter Python version errors:

```bash
# Check your Python version
python --version

# Use python3 explicitly if needed
python3 -m pip install git-reporter
```

### Permission errors

If you encounter permission errors:

```bash
# Install for current user only
pip install --user git-reporter

# Or use pipx
pipx install git-reporter
```

## Updating

To update git-reporter to the latest version:

```bash
# With pip
pip install --upgrade git-reporter

# With UV
uv pip install --upgrade git-reporter

# With pipx
pipx upgrade git-reporter
```

## Uninstallation

To uninstall git-reporter:

```bash
# With pip
pip uninstall git-reporter

# With pipx
pipx uninstall git-reporter
```

## Development Installation

For contributing to git-reporter, see the [Contributing Guide](../development/contributing.md).
