# Example Configuration

Complete example configuration file for git-reporter.

```yaml
# You can use this in multiple ways:
# 1. Copy to ~/.git-reporter/config.yaml (global config)
# 2. Save as git-reporter.yaml in your project directory (local config)
# 3. Save as git-reporter.yml in your project directory (local config)
# Local configs take priority over global config

# AI provider to use: 'openai' or 'gemini'
ai_provider: openai

# Default report period: 'daily', 'weekly', 'monthly', 'quarterly', or 'yearly'
default_period: weekly

# OpenAI configuration
# Model options: gpt-4o, gpt-4o-mini, gpt-4-turbo, gpt-3.5-turbo
openai_model: gpt-4o-mini

# Gemini configuration  
# Model options: gemini-2.0-flash-exp, gemini-1.5-pro, gemini-1.5-flash
gemini_model: gemini-2.0-flash-exp

# List of repositories to analyze
# Use 'repos' or 'repositories' (both are supported)
repos:
  # Example local repository
  - name: my-local-project
    path: /home/user/projects/my-project
    author_email: developer@example.com  # Optional: filter by author email
  
  # Example remote repository (will be cloned automatically)
  - name: my-remote-project
    repo: https://github.com/username/my-remote-project.git
    author_email: developer@example.com
  
  # Another local repository using ~ for home directory
  - name: another-project
    path: ~/projects/another-project
    # If author_email is not specified, all commits will be included
  
  # Add more repositories as needed
  # Local repository:
  # - name: third-project
  #   path: /path/to/third-project
  #   author_email: developer@example.com
  
  # Remote repository:
  # - name: github-project
  #   repo: https://github.com/org/repo.git
  #   author_email: developer@example.com

# Note: API keys should NOT be stored in this file for security reasons
# Set them as environment variables instead:
#   export OPENAI_API_KEY='your-openai-api-key'
#   export GEMINI_API_KEY='your-gemini-api-key'

\`\`\`
