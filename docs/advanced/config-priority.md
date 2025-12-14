# Local vs Global Config

Understanding configuration file priority and best practices.

## Configuration Priority

git-reporter searches for configuration files in the following order (highest to lowest priority):

1. **Command-line specified config** (`--config` option)
2. **Local config files** (in current directory):
   - `git-reporter.yaml`
   - `git-reporter.yml`
   - `.git-reporter.yaml`
   - `.git-reporter.yml`
3. **Global config** (`~/.git-reporter/config.yaml`)

The first configuration file found is used.

## Global Configuration

### Location

- **Linux/Mac**: `~/.git-reporter/config.yaml`
- **Windows**: `%USERPROFILE%\.git-reporter\config.yaml`

### When to Use

Use global configuration for:

- Default AI provider settings
- Personal default repositories
- Standard report periods
- Cross-project defaults

### Example

```yaml
# ~/.git-reporter/config.yaml
ai_provider: openai
default_period: weekly
openai_model: gpt-4o-mini
repos:
  - name: personal-blog
    path: ~/projects/blog
    author_email: personal@email.com
```

## Local Configuration

### Location

In your project directory:
- `git-reporter.yaml` (recommended)
- `git-reporter.yml`
- `.git-reporter.yaml` (hidden)
- `.git-reporter.yml` (hidden)

### When to Use

Use local configuration for:

- Project-specific repositories
- Team-specific settings
- Different AI providers per project
- Client-specific configurations

### Example

```yaml
# ~/work/client-project/git-reporter.yaml
ai_provider: gemini
default_period: monthly
repos:
  - name: client-frontend
    path: ./frontend
    author_email: work@company.com
  
  - name: client-backend
    path: ./backend
    author_email: work@company.com
```

## Use Cases

### Scenario 1: Personal + Work Separation

**Global Config** (`~/.git-reporter/config.yaml`):
```yaml
ai_provider: openai
repos:
  - name: personal-site
    path: ~/personal/website
    author_email: personal@email.com
```

**Work Project** (`~/work/git-reporter.yaml`):
```yaml
ai_provider: gemini  # Different provider for work
repos:
  - name: work-project
    path: ~/work/project
    author_email: work@company.com
```

### Scenario 2: Multiple Clients

Each client directory has its own config:

**Client A** (`~/clients/client-a/git-reporter.yaml`):
```yaml
repos:
  - name: client-a-frontend
    repo: https://github.com/client-a/frontend.git
    author_email: consultant@email.com
```

**Client B** (`~/clients/client-b/git-reporter.yaml`):
```yaml
repos:
  - name: client-b-backend
    repo: https://github.com/client-b/backend.git
    author_email: consultant@email.com
```

### Scenario 3: Team Configuration

**Team Shared Config** (checked into Git):
```yaml
# git-reporter.yaml (in team repo)
ai_provider: openai
default_period: weekly
repos:
  - name: team-project
    path: .
    # No email filter - includes all team members
```

Each team member can generate reports without setup.

## Best Practices

### 1. Version Control

**DO**:
- ✅ Commit local config files to project repos
- ✅ Use example configs for sensitive information
- ✅ Document configuration in README

**DON'T**:
- ❌ Commit API keys
- ❌ Commit personal email addresses
- ❌ Commit absolute paths

### 2. Gitignore Patterns

```gitignore
# If config contains sensitive data
git-reporter.yaml

# Or use a local override
git-reporter.local.yaml
```

### 3. Configuration Templates

Provide example configs in your repositories:

```yaml
# git-reporter.example.yaml
ai_provider: openai
default_period: weekly
repos:
  - name: project-name
    path: .
    author_email: YOUR_EMAIL_HERE  # Replace with your email
```

### 4. Environment-Specific Configs

```bash
# Development
git-reporter generate --config configs/dev.yaml

# Staging
git-reporter generate --config configs/staging.yaml

# Production
git-reporter generate --config configs/prod.yaml
```

## Overriding Configuration

### Command-Line Override

```bash
# Use specific config file
git-reporter generate --config ~/custom-config.yaml

# Override AI provider
git-reporter generate --provider gemini

# Override repositories
git-reporter generate --repo frontend --repo backend
```

### Environment Variables

API keys always come from environment variables, regardless of config file:

```bash
export OPENAI_API_KEY='your-key'
export GEMINI_API_KEY='your-key'
```

## Troubleshooting

### Which Config is Being Used?

```bash
# List repos shows the active configuration
git-reporter list-repos

# Check current directory for local configs
ls -la git-reporter.y*ml .git-reporter.y*ml
```

### Config Not Found

```
Error: Configuration file not found
```

**Solutions**:
1. Run `git-reporter init` to create global config
2. Create local `git-reporter.yaml` in current directory
3. Specify config explicitly with `--config`

### Wrong Config Being Used

If the wrong config is being used:

1. Check for local config files in current directory
2. Verify global config location
3. Use `--config` to specify explicitly

## Migration Guide

### From Global to Local

1. Copy global config:
   ```bash
   cp ~/.git-reporter/config.yaml ./git-reporter.yaml
   ```

2. Edit local config for project-specific settings

3. Test:
   ```bash
   git-reporter list-repos
   ```

### From Local to Global

1. Merge local configs into global:
   ```bash
   cat git-reporter.yaml >> ~/.git-reporter/config.yaml
   ```

2. Remove local config:
   ```bash
   rm git-reporter.yaml
   ```

## See Also

- [Configuration](../getting-started/configuration.md) - Complete configuration guide
- [Usage Examples](../user-guide/usage-examples.md) - Real-world scenarios
- [CLI Commands](../user-guide/cli-commands.md) - Command reference
