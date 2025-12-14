# CLI Commands

Complete reference for all git-reporter command-line interface commands.

## Overview

git-reporter provides a simple and intuitive CLI with the following commands:

- `init` - Initialize configuration
- `add-repo` - Add a repository to configuration
- `list-repos` - List configured repositories
- `generate` - Generate a report

## Global Options

All commands support the following global options:

### `--help`

Show help message and exit.

```bash
git-reporter --help
git-reporter generate --help
```

### `--version`

Show the version and exit.

```bash
git-reporter --version
```

## Commands

### `init`

Initialize a new git-reporter configuration file.

```bash
git-reporter init [OPTIONS]
```

#### Options

| Option | Short | Type | Description |
|--------|-------|------|-------------|
| `--config` | `-c` | Path | Custom configuration file path |

#### Examples

```bash
# Create default global config
git-reporter init

# Create config at custom location
git-reporter init --config ~/my-config.yaml
```

#### Behavior

- Creates `~/.git-reporter/config.yaml` by default
- Prompts for confirmation if config already exists
- Creates directory structure if needed

---

### `add-repo`

Add a repository to the configuration.

```bash
git-reporter add-repo [OPTIONS]
```

#### Options

| Option | Short | Type | Required | Description |
|--------|-------|------|----------|-------------|
| `--name` | `-n` | String | Yes | Repository name |
| `--path` | `-p` | Path | * | Local path to repository |
| `--repo` | `-r` | URL | * | Remote repository URL |
| `--email` | `-e` | Email | No | Filter commits by author email |
| `--config` | `-c` | Path | No | Custom configuration file path |

\* Either `--path` or `--repo` must be specified, but not both.

#### Examples

```bash
# Add local repository
git-reporter add-repo \
  --name my-project \
  --path ~/projects/my-project \
  --email developer@example.com

# Add remote repository
git-reporter add-repo \
  --name github-project \
  --repo https://github.com/username/repo.git \
  --email developer@example.com

# Add to custom config
git-reporter add-repo \
  --config ~/work-repos.yaml \
  --name work-project \
  --path ~/work/project
```

#### Behavior

- Adds repository to the configuration file
- Prompts for confirmation if repository name already exists
- Validates that path exists (for local repos)
- Supports both local and remote repositories

---

### `list-repos`

List all configured repositories.

```bash
git-reporter list-repos [OPTIONS]
```

#### Options

| Option | Short | Type | Description |
|--------|-------|------|-------------|
| `--config` | `-c` | Path | Custom configuration file path |

#### Examples

```bash
# List repos in default config
git-reporter list-repos

# List repos in custom config
git-reporter list-repos --config ~/work-repos.yaml
```

#### Output

Displays a table with:

- Repository name
- Type (Local/Remote)
- Location (path or URL)
- Author email (if configured)

#### Example Output

```
                         Configured Repositories
┏━━━━━━━━━━━━━━━┳━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━┓
┃ Name          ┃ Type   ┃ Location                  ┃ Author Email       ┃
┡━━━━━━━━━━━━━━━╇━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━┩
│ frontend      │ Local  │ ~/work/frontend           │ dev@company.com    │
│ backend       │ Remote │ https://github.com/...    │ dev@company.com    │
│ mobile        │ Remote │ https://github.com/...    │ dev@company.com    │
└───────────────┴────────┴───────────────────────────┴────────────────────┘
```

---

### `generate`

Generate a report from git commit history.

```bash
git-reporter generate [OPTIONS]
```

#### Options

| Option | Short | Type | Default | Description |
|--------|-------|------|---------|-------------|
| `--config` | `-c` | Path | Auto-detect | Custom configuration file path |
| `--period` | `-p` | Choice | `weekly` | Report period |
| `--start` | `-s` | Date | - | Start date for custom period (YYYY-MM-DD) |
| `--end` | `-e` | Date | - | End date for custom period (YYYY-MM-DD) |
| `--repo` | `-r` | String | All | Specific repositories to include (can be used multiple times) |
| `--output` | `-o` | Path | - | Output file path |
| `--provider` | - | Choice | Config | AI provider to use (overrides config) |

#### Period Options

- `daily` - Today's commits
- `weekly` - Current week (Monday to now)
- `monthly` - Current month
- `quarterly` - Current quarter
- `yearly` - Current year
- `custom` - Custom date range (requires `--start` and `--end`)

#### Provider Options

- `openai` - Use OpenAI GPT
- `gemini` - Use Google Gemini

#### Examples

##### Basic Reports

```bash
# Weekly report (default)
git-reporter generate

# Daily report
git-reporter generate --period daily

# Monthly report
git-reporter generate --period monthly

# Quarterly report
git-reporter generate --period quarterly

# Yearly report
git-reporter generate --period yearly
```

##### Custom Date Range

```bash
# Q4 2024 report
git-reporter generate \
  --period custom \
  --start 2024-10-01 \
  --end 2024-12-31

# Specific month
git-reporter generate \
  --period custom \
  --start 2024-11-01 \
  --end 2024-11-30
```

##### Specific Repositories

```bash
# Single repository
git-reporter generate --repo frontend

# Multiple repositories
git-reporter generate \
  --repo frontend \
  --repo backend \
  --repo mobile

# Monthly report for specific repos
git-reporter generate \
  --period monthly \
  --repo frontend \
  --repo backend
```

##### Save to File

```bash
# Save weekly report
git-reporter generate --output weekly-report.md

# Save with timestamp in filename
git-reporter generate --output "report-$(date +%Y-%m-%d).md"

# Save monthly report
git-reporter generate \
  --period monthly \
  --output monthly-$(date +%Y-%m).md
```

##### Override AI Provider

```bash
# Use Gemini instead of configured provider
git-reporter generate --provider gemini

# Use OpenAI instead of configured provider
git-reporter generate --provider openai
```

##### Combined Options

```bash
# Comprehensive report
git-reporter generate \
  --period monthly \
  --repo frontend \
  --repo backend \
  --provider openai \
  --output reports/2024-12-monthly.md

# Custom date range with specific repos
git-reporter generate \
  --period custom \
  --start 2024-01-01 \
  --end 2024-12-31 \
  --repo my-project \
  --output yearly-2024.md
```

#### Output Format

The generated report includes:

- **Header Panel**: Period, commit count, generation timestamp
- **Summary Section**: AI-generated professional summary
- **Commit Details**: Optional detailed commit list (when saving to file)

##### Console Output Example

```
╭──────────────────────────────────────────────╮
│ WEEKLY REPORT                                │
│ Period: 2024-12-08 to 2024-12-14            │
│ Commits: 23                                  │
│ Generated: 2024-12-14 10:30:45              │
╰──────────────────────────────────────────────╯

Summary:

Weekly Work Report
==================

This week's development focused on...
[AI-generated summary]
```

##### File Output Example

```markdown
# WEEKLY Report

Period: 2024-12-08 to 2024-12-14
Commits: 23
Generated: 2024-12-14 10:30:45

## Summary

[AI-generated summary]

## Commit Details

- [frontend] 2024-12-14 10:15: Add user authentication
- [backend] 2024-12-13 15:30: Implement API endpoints
- [mobile] 2024-12-12 09:45: Update UI components
...
```

#### Behavior

- Auto-detects local config file if present
- Falls back to global config if no local config
- Clones remote repositories to temporary directories
- Cleans up temporary directories after generation
- Displays progress indicators for long operations
- Handles errors gracefully with helpful messages

---

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | General error (configuration, API, etc.) |
| 2 | Invalid arguments or options |

## Environment Variables

git-reporter respects the following environment variables:

| Variable | Description |
|----------|-------------|
| `OPENAI_API_KEY` | OpenAI API key |
| `GEMINI_API_KEY` | Google Gemini API key |

## Common Patterns

### Daily Standup Report

```bash
git-reporter generate --period daily
```

### Weekly Manager Report

```bash
git-reporter generate --period weekly --output weekly-report.md
```

### Monthly Review

```bash
git-reporter generate \
  --period monthly \
  --output reports/$(date +%Y-%m)-report.md
```

### Quarterly Summary

```bash
git-reporter generate \
  --period quarterly \
  --output Q$(date +%q)-$(date +%Y).md
```

### Annual Report

```bash
git-reporter generate \
  --period yearly \
  --output $(date +%Y)-annual-report.md
```

## See Also

- [Configuration](../getting-started/configuration.md) - Configure git-reporter
- [Usage Examples](usage-examples.md) - Real-world usage scenarios
- [Troubleshooting](../reference/troubleshooting.md) - Common issues and solutions
