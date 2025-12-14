# Configuration Schema

Complete reference for the configuration file schema.

## Full Schema

```yaml
# AI Provider Settings
ai_provider: string              # Required: 'openai' or 'gemini'
openai_model: string            # Optional: default 'gpt-4o-mini'
openai_api_key: string          # Not recommended: use env var instead
gemini_model: string            # Optional: default 'gemini-2.0-flash-exp'
gemini_api_key: string          # Not recommended: use env var instead

# Default Settings
default_period: string          # Optional: default 'weekly'
                               # Options: daily, weekly, monthly, quarterly, yearly, custom

# Repositories (required)
repos:                          # or 'repositories' (both work)
  - name: string               # Required: unique repository name
    path: string               # Optional: local repository path
    repo: string               # Optional: remote repository URL
    author_email: string       # Optional: filter by author email
```

!!! note "Either path or repo required"
    Each repository must have either `path` (local) or `repo` (remote), but not both.

## Field Reference

### Top-Level Fields

#### `ai_provider`

- **Type**: `string`
- **Required**: Yes
- **Options**: `openai`, `gemini`
- **Default**: `openai`
- **Description**: AI service to use for report generation

#### `default_period`

- **Type**: `string`
- **Required**: No
- **Options**: `daily`, `weekly`, `monthly`, `quarterly`, `yearly`, `custom`
- **Default**: `weekly`
- **Description**: Default time period for reports

#### `openai_model`

- **Type**: `string`
- **Required**: No (when using OpenAI)
- **Default**: `gpt-4o-mini`
- **Options**: `gpt-4o`, `gpt-4o-mini`, `gpt-4-turbo`, `gpt-3.5-turbo`
- **Description**: OpenAI model to use

#### `gemini_model`

- **Type**: `string`
- **Required**: No (when using Gemini)
- **Default**: `gemini-2.0-flash-exp`
- **Options**: `gemini-2.0-flash-exp`, `gemini-1.5-pro`, `gemini-1.5-flash`
- **Description**: Google Gemini model to use

### Repository Fields

#### `name`

- **Type**: `string`
- **Required**: Yes
- **Description**: Unique identifier for the repository
- **Example**: `my-project`, `frontend-app`, `backend-api`

#### `path`

- **Type**: `string` (file path)
- **Required**: One of `path` or `repo` required
- **Description**: Local path to Git repository
- **Supports**: Absolute paths, `~` for home directory
- **Example**: `/home/user/projects/my-app`, `~/projects/my-app`, `./my-app`

#### `repo`

- **Type**: `string` (URL)
- **Required**: One of `path` or `repo` required
- **Description**: Remote Git repository URL
- **Supports**: HTTPS and SSH URLs
- **Example**: `https://github.com/user/repo.git`, `git@github.com:user/repo.git`

#### `author_email`

- **Type**: `string` (email address)
- **Required**: No
- **Default**: Include all commits
- **Description**: Filter commits by this author email
- **Example**: `developer@example.com`

## Validation Rules

1. At least one repository must be configured
2. Each repository must have a unique `name`
3. Each repository must have either `path` or `repo`, but not both
4. `author_email` must be a valid email format (if provided)
5. `ai_provider` must be either `openai` or `gemini`
6. `default_period` must be a valid period option

## Complete Examples

See [Example Configuration](example-config.md) for more examples.

## See Also

- [Configuration Guide](../getting-started/configuration.md) - Configuration tutorial
- [Example Config](example-config.md) - Complete examples
