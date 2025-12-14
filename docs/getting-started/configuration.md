# Configuration

Learn how to configure git-reporter for your needs.

## Configuration File Locations

git-reporter supports multiple configuration file locations with the following priority:

### 1. Local Config Files (Highest Priority)

Searched in the current directory in this order:

- `git-reporter.yaml`
- `git-reporter.yml`
- `.git-reporter.yaml`
- `.git-reporter.yml`

### 2. Global Config File

- `~/.git-reporter/config.yaml`

!!! tip "Config Priority"
    Local config files in your current directory take priority over the global config. This allows you to have project-specific configurations while maintaining a default global configuration.

## Configuration Structure

### Basic Configuration

```yaml
# AI Provider (openai or gemini)
ai_provider: openai

# Default report period (daily, weekly, monthly, quarterly, yearly, custom)
default_period: weekly

# OpenAI settings
openai_model: gpt-4o-mini

# Gemini settings
gemini_model: gemini-2.0-flash-exp

# Repositories to analyze
repos:
  - name: my-project
    path: ~/projects/my-project
    author_email: you@example.com
```

## Configuration Options

### AI Provider Settings

#### `ai_provider`

The AI service to use for generating reports.

- **Type**: String
- **Options**: `openai` or `gemini`
- **Default**: `openai`
- **Required**: Yes

```yaml
ai_provider: openai
```

#### `openai_model`

The OpenAI model to use.

- **Type**: String
- **Options**: `gpt-4o`, `gpt-4o-mini`, `gpt-4-turbo`, `gpt-3.5-turbo`
- **Default**: `gpt-4o-mini`
- **Required**: No (if using OpenAI)

```yaml
openai_model: gpt-4o-mini
```

#### `gemini_model`

The Google Gemini model to use.

- **Type**: String
- **Options**: `gemini-2.0-flash-exp`, `gemini-1.5-pro`, `gemini-1.5-flash`
- **Default**: `gemini-2.0-flash-exp`
- **Required**: No (if using Gemini)

```yaml
gemini_model: gemini-2.0-flash-exp
```

### Report Settings

#### `default_period`

The default time period for reports.

- **Type**: String
- **Options**: `daily`, `weekly`, `monthly`, `quarterly`, `yearly`, `custom`
- **Default**: `weekly`
- **Required**: No

```yaml
default_period: weekly
```

### Repository Configuration

#### `repos` (or `repositories`)

List of repositories to analyze.

- **Type**: Array of repository objects
- **Required**: Yes

Each repository object has the following fields:

##### `name`

Unique identifier for the repository.

- **Type**: String
- **Required**: Yes

##### `path`

Local path to the Git repository. Use this for local repositories.

- **Type**: String
- **Required**: One of `path` or `repo` must be specified

```yaml
repos:
  - name: local-project
    path: ~/projects/my-project
```

##### `repo`

Remote repository URL. The repository will be cloned automatically when generating reports.

- **Type**: String (URL)
- **Required**: One of `path` or `repo` must be specified

```yaml
repos:
  - name: remote-project
    repo: https://github.com/username/repo.git
```

##### `author_email`

Filter commits by this author email address.

- **Type**: String (email)
- **Required**: No
- **Default**: Include all commits

```yaml
repos:
  - name: my-project
    path: ~/projects/my-project
    author_email: you@example.com
```

## Complete Example

```yaml title="git-reporter.yaml"
# AI Configuration
ai_provider: openai
openai_model: gpt-4o-mini
gemini_model: gemini-2.0-flash-exp

# Default settings
default_period: weekly

# Repositories
repos:
  # Local repository
  - name: frontend
    path: ~/work/frontend
    author_email: developer@company.com
  
  # Remote repository (auto-cloned)
  - name: backend
    repo: https://github.com/company/backend.git
    author_email: developer@company.com
  
  # Multiple repos from the same organization
  - name: mobile-app
    repo: https://github.com/company/mobile.git
    author_email: developer@company.com
  
  # Personal project (no email filter)
  - name: side-project
    path: ~/personal/side-project
```

## API Keys

!!! warning "Security"
    **Never** store API keys in configuration files. Always use environment variables.

### OpenAI

```bash
export OPENAI_API_KEY='your-openai-api-key'
```

Get your API key from [OpenAI Platform](https://platform.openai.com/).

### Google Gemini

```bash
export GEMINI_API_KEY='your-gemini-api-key'
```

Get your API key from [Google AI Studio](https://aistudio.google.com/).

### Making API Keys Permanent

Add the export command to your shell configuration file:

```bash
# For Bash
echo 'export OPENAI_API_KEY="your-key"' >> ~/.bashrc
source ~/.bashrc

# For Zsh
echo 'export OPENAI_API_KEY="your-key"' >> ~/.zshrc
source ~/.zshrc

# For Fish
echo 'set -gx OPENAI_API_KEY "your-key"' >> ~/.config/fish/config.fish
source ~/.config/fish/config.fish
```

## Configuration via CLI

You can also manage configuration using CLI commands:

### Initialize Configuration

```bash
git-reporter init
```

Creates a default global configuration file at `~/.git-reporter/config.yaml`.

### Add Repository

```bash
# Add local repository
git-reporter add-repo \
  --name my-project \
  --path ~/projects/my-project \
  --email your@email.com

# Add remote repository
git-reporter add-repo \
  --name github-project \
  --repo https://github.com/username/repo.git \
  --email your@email.com
```

### List Repositories

```bash
git-reporter list-repos
```

Shows all configured repositories with their type (Local/Remote) and location.

## Advanced Configuration

### Multiple Configuration Profiles

You can maintain different configuration files for different purposes:

```bash
# Work projects
git-reporter generate --config ~/configs/work.yaml

# Personal projects
git-reporter generate --config ~/configs/personal.yaml

# Open source contributions
git-reporter generate --config ~/configs/opensource.yaml
```

### Project-Specific Configurations

Create a `git-reporter.yaml` in each project directory:

```
~/work/project-a/
  ├── git-reporter.yaml  # Config for project-a
  └── ...

~/work/project-b/
  ├── git-reporter.yaml  # Config for project-b
  └── ...
```

When you run `git-reporter generate` in each directory, it uses the local config automatically.

## See Also

- [Quick Start](quickstart.md) - Get started quickly
- [CLI Commands](../user-guide/cli-commands.md) - All available commands
- [Example Config](../reference/example-config.md) - More configuration examples
- [Troubleshooting](../reference/troubleshooting.md) - Common configuration issues
