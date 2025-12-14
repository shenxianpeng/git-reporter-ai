# git-reporter Usage Examples

This document provides practical examples of using git-reporter with the new local config and remote repository features.

## Configuration File Locations

git-reporter now supports multiple configuration file locations with the following priority:

1. **Local config files** (in current directory):
   - `git-reporter.yaml`
   - `git-reporter.yml`
   - `.git-reporter.yaml`
   - `.git-reporter.yml`

2. **Global config file**:
   - `~/.git-reporter/config.yaml`

Local configs take priority over the global config, making it easy to have project-specific configurations.

## Working with Local Config Files

### Example 1: Create a Project-Specific Config

```bash
# Navigate to your project directory
cd ~/my-projects

# Create a local config file
cat > git-reporter.yaml << 'EOF'
ai_provider: openai
default_period: weekly
openai_model: gpt-4o-mini
repos:
  - name: my-app
    repo: https://github.com/username/my-app.git
    author_email: you@example.com
  - name: my-backend
    repo: https://github.com/username/my-backend.git
    author_email: you@example.com
EOF

# Generate report using local config
git-reporter generate --period monthly
```

## Working with Remote Repositories

### Example 2: Add Remote GitHub Repository

```bash
# Add a remote repository (will be cloned automatically when generating reports)
git-reporter add-repo \
  --name my-open-source-project \
  --repo https://github.com/username/repo.git \
  --email your@email.com

# Generate a report
git-reporter generate --period weekly
```

### Example 3: Mix Local and Remote Repositories

```yaml
# git-reporter.yaml
ai_provider: openai
default_period: weekly
openai_model: gpt-4o-mini
repos:
  # Local repository
  - name: local-dev-project
    path: ~/projects/my-local-project
    author_email: you@example.com
  
  # Remote repositories (auto-cloned when needed)
  - name: github-project-1
    repo: https://github.com/org/project1.git
    author_email: you@example.com
  
  - name: github-project-2
    repo: https://github.com/org/project2.git
    author_email: you@example.com
```

## Working with Multiple Projects

### Example 4: Team Configuration

```yaml
# git-reporter.yaml for team reporting
ai_provider: openai
default_period: weekly
openai_model: gpt-4o-mini
repos:
  # Frontend repositories
  - name: web-app
    repo: https://github.com/company/web-app.git
    author_email: frontend-dev@company.com
  
  - name: mobile-app
    repo: https://github.com/company/mobile-app.git
    author_email: mobile-dev@company.com
  
  # Backend repositories
  - name: api-service
    repo: https://github.com/company/api-service.git
    author_email: backend-dev@company.com
  
  - name: data-pipeline
    repo: https://github.com/company/data-pipeline.git
    author_email: data-engineer@company.com
```

### Example 5: Generate Report for Specific Repos Only

```bash
# Generate report for only specific repositories
git-reporter generate --period monthly \
  --repo web-app \
  --repo api-service \
  --output monthly-report.md
```

## Advanced Use Cases

### Example 6: Custom Date Range Report

```bash
# Generate a quarterly report (Q4 2024)
git-reporter generate \
  --period custom \
  --start 2024-10-01 \
  --end 2024-12-31 \
  --output Q4-2024-report.md
```

### Example 7: Different Config for Different Projects

```bash
# Project A directory
cd ~/projects/projectA
cat > git-reporter.yaml << 'EOF'
ai_provider: openai
repos:
  - name: projectA
    path: .
    author_email: dev@company.com
EOF

# Project B directory
cd ~/projects/projectB
cat > git-reporter.yaml << 'EOF'
ai_provider: gemini
repos:
  - name: projectB
    path: .
    author_email: dev@company.com
EOF

# Each directory uses its own config automatically
cd ~/projects/projectA && git-reporter generate
cd ~/projects/projectB && git-reporter generate --provider gemini
```

### Example 8: Using Custom Config Path

```bash
# Use a specific config file
git-reporter generate --config ~/configs/work-repos.yaml --period weekly

# Add repo to a specific config file
git-reporter add-repo \
  --config ~/configs/work-repos.yaml \
  --name new-project \
  --repo https://github.com/company/new-project.git \
  --email you@company.com
```

## Real-World Scenarios

### Scenario 1: Personal Weekly Report

```yaml
# ~/personal-projects/git-reporter.yaml
ai_provider: openai
default_period: weekly
openai_model: gpt-4o-mini
repos:
  - name: personal-blog
    repo: https://github.com/username/blog.git
    author_email: you@gmail.com
  
  - name: side-project
    path: ~/projects/side-project
    author_email: you@gmail.com
```

```bash
cd ~/personal-projects
git-reporter generate  # Uses local config automatically
```

### Scenario 2: Company Monthly Report

```yaml
# ~/work/git-reporter.yaml
ai_provider: openai
default_period: monthly
openai_model: gpt-4o-mini
repos:
  - name: main-product
    repo: https://github.com/company/main-product.git
    author_email: you@company.com
  
  - name: mobile-app
    repo: https://github.com/company/mobile.git
    author_email: you@company.com
  
  - name: backend-services
    repo: https://github.com/company/backend.git
    author_email: you@company.com
```

```bash
cd ~/work
# Generate monthly report and save for manager
git-reporter generate --output "$(date +%Y-%m)-work-report.md"
```

### Scenario 3: Open Source Contribution Report

```yaml
# ~/opensource/git-reporter.yaml
ai_provider: gemini
default_period: monthly
repos:
  - name: kubernetes
    repo: https://github.com/kubernetes/kubernetes.git
    author_email: your@email.com
  
  - name: tensorflow
    repo: https://github.com/tensorflow/tensorflow.git
    author_email: your@email.com
  
  - name: vscode
    repo: https://github.com/microsoft/vscode.git
    author_email: your@email.com
```

```bash
cd ~/opensource
# Generate quarterly contribution report
git-reporter generate --period quarterly --output my-oss-contributions.md
```

## Tips and Best Practices

1. **Local vs Global Config**:
   - Use global config (`~/.git-reporter/config.yaml`) for personal default settings
   - Use local config (`git-reporter.yaml`) for project-specific or team settings

2. **Remote Repository Performance**:
   - Remote repositories are cloned to temporary directories during report generation
   - Temp directories are cleaned up automatically after report generation
   - For frequently used repos, consider cloning locally and using `path` instead of `repo`

3. **Security**:
   - Always use environment variables for API keys: `export OPENAI_API_KEY='your-key'`
   - Never commit API keys to version control
   - Add `git-reporter.yaml` to `.gitignore` if it contains sensitive author emails

4. **Config File Naming**:
   - Use `git-reporter.yaml` (recommended) or `git-reporter.yml`
   - Hidden files (`.git-reporter.yaml`) work but are less discoverable

5. **Repository Organization**:
   - Group related repos in the same config file
   - Use descriptive names for repositories
   - Add author_email filters to focus on your contributions

## Troubleshooting

### Config Not Found

```bash
# Check which config file is being used
git-reporter list-repos

# If it says "No repositories configured", create a config:
git-reporter init  # Creates global config
# OR
touch git-reporter.yaml  # Create local config
```

### Remote Repository Clone Failures

```bash
# Ensure you have access to the remote repository
git clone https://github.com/username/repo.git /tmp/test-clone

# For private repos, ensure SSH keys or credentials are set up
# git-reporter uses the same git credentials as your system
```

### Both Path and Repo Specified

```bash
# Error: Cannot specify both --path and --repo
# Solution: Use one or the other
git-reporter add-repo --name myrepo --path ~/projects/myrepo  # Local
git-reporter add-repo --name myrepo --repo https://github.com/user/repo.git  # Remote
```

## More Information

- See [Quick Start](../getting-started/quickstart.md) for getting started
- See [Documentation Home](../index.md) for complete documentation
- See [Example Configuration](../reference/example-config.md) for configuration examples
