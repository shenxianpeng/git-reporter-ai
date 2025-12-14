# Remote Repositories

Learn how to work with remote repositories in git-reporter.

## Overview

git-reporter can automatically clone and analyze remote Git repositories from GitHub, GitLab, Bitbucket, and other Git hosting services. This eliminates the need to manually clone repositories just to generate reports.

## How It Works

When you specify a remote repository URL:

1. git-reporter clones the repository to a temporary directory
2. Analyzes the commits based on your configuration
3. Generates the report
4. Automatically cleans up the temporary directory

## Configuration

### Adding Remote Repositories

#### Via CLI

```bash
git-reporter add-repo \
  --name my-remote-project \
  --repo https://github.com/username/repo.git \
  --email your@email.com
```

#### Via Config File

```yaml
repos:
  - name: github-project
    repo: https://github.com/username/repo.git
    author_email: your@email.com
  
  - name: gitlab-project
    repo: https://gitlab.com/username/project.git
    author_email: your@email.com
  
  - name: bitbucket-project
    repo: https://bitbucket.org/username/repo.git
    author_email: your@email.com
```

## Supported Git Hosts

git-reporter works with any Git hosting service that supports standard Git protocols:

### GitHub

```yaml
repos:
  - name: github-public
    repo: https://github.com/username/repo.git
  
  - name: github-ssh
    repo: git@github.com:username/repo.git
```

### GitLab

```yaml
repos:
  - name: gitlab-project
    repo: https://gitlab.com/username/project.git
  
  - name: gitlab-self-hosted
    repo: https://gitlab.company.com/team/project.git
```

### Bitbucket

```yaml
repos:
  - name: bitbucket-project
    repo: https://bitbucket.org/username/repo.git
```

### Self-Hosted Git

```yaml
repos:
  - name: company-git
    repo: https://git.company.com/project.git
```

## Authentication

### Public Repositories

Public repositories work out of the box:

```yaml
repos:
  - name: public-repo
    repo: https://github.com/username/public-repo.git
```

### Private Repositories

For private repositories, configure Git authentication on your system:

#### HTTPS with Credentials

```bash
# Configure Git credential helper
git config --global credential.helper store

# Clone once to store credentials
git clone https://github.com/username/private-repo.git /tmp/test
# Enter credentials when prompted
rm -rf /tmp/test

# git-reporter will now use stored credentials
```

#### SSH Keys

```bash
# Ensure SSH keys are set up
ssh-add ~/.ssh/id_rsa

# Use SSH URL in config
repos:
  - name: private-repo
    repo: git@github.com:username/private-repo.git
```

#### GitHub Personal Access Token

```bash
# Create token at: https://github.com/settings/tokens

# Configure git to use token
git config --global url."https://${GITHUB_TOKEN}@github.com/".insteadOf "https://github.com/"

# Or use token in URL (not recommended for config files)
repos:
  - name: private-repo
    repo: https://TOKEN@github.com/username/repo.git
```

## Performance Considerations

### Clone Depth

git-reporter clones the full repository history by default. For large repositories, this can be slow.

**Future improvement**: We plan to add support for shallow clones:

```yaml
# Coming soon
repos:
  - name: large-repo
    repo: https://github.com/org/large-repo.git
    clone_depth: 100  # Only last 100 commits
```

### Caching

Currently, repositories are cloned fresh each time. 

**Future improvement**: We plan to add caching support:

```yaml
# Coming soon
repos:
  - name: frequently-used
    repo: https://github.com/org/repo.git
    cache: true
    cache_ttl: 3600  # Cache for 1 hour
```

### Local Mirror

For frequently used remote repositories, consider maintaining a local mirror:

```bash
# Create a local mirror
git clone --mirror https://github.com/org/repo.git ~/git-mirrors/repo.git

# Use local mirror in config
repos:
  - name: repo-mirror
    path: ~/git-mirrors/repo.git
```

## Mixed Local and Remote

You can mix local and remote repositories:

```yaml
repos:
  # Local repositories
  - name: local-project-1
    path: ~/projects/project1
    author_email: dev@example.com
  
  - name: local-project-2
    path: ~/projects/project2
    author_email: dev@example.com
  
  # Remote repositories
  - name: github-project
    repo: https://github.com/org/project.git
    author_email: dev@example.com
  
  - name: gitlab-project
    repo: https://gitlab.com/org/project.git
    author_email: dev@example.com
```

## Use Cases

### Open Source Contributions

Track your contributions across multiple open-source projects:

```yaml
repos:
  - name: kubernetes
    repo: https://github.com/kubernetes/kubernetes.git
    author_email: yourcontributions@email.com
  
  - name: tensorflow
    repo: https://github.com/tensorflow/tensorflow.git
    author_email: yourcontributions@email.com
```

### Multi-Organization Work

Work across different company repositories:

```yaml
repos:
  - name: client-a-frontend
    repo: https://github.com/client-a/frontend.git
    author_email: consultant@email.com
  
  - name: client-b-backend
    repo: https://github.com/client-b/backend.git
    author_email: consultant@email.com
```

### Team Repositories

Generate team reports without local clones:

```yaml
repos:
  - name: team-web-app
    repo: https://github.com/company/web-app.git
    # No email filter = all team members
  
  - name: team-mobile-app
    repo: https://github.com/company/mobile-app.git
```

## Troubleshooting

### Clone Failures

```
Error: Failed to clone repository
```

**Solutions**:

1. Check repository URL is correct
2. Verify you have access to the repository
3. Check network connectivity
4. Verify Git credentials are configured

### Authentication Errors

```
Error: Authentication failed
```

**Solutions**:

1. For HTTPS: Configure credential helper
2. For SSH: Add SSH key to ssh-agent
3. For tokens: Ensure token has repository access

### Slow Cloning

For large repositories:

1. Use local clones instead of remote
2. Consider maintaining a local mirror
3. Wait for shallow clone support (coming soon)

### Temporary Directory Issues

```
Warning: Failed to cleanup temporary directory
```

This is usually safe to ignore. The directory will be cleaned up on next system restart. To clean up manually:

```bash
# Linux/Mac
rm -rf /tmp/git-reporter-*

# Windows
del /s /q %TEMP%\git-reporter-*
```

## Best Practices

1. **Use SSH for private repos**: More secure than HTTPS with tokens
2. **Group related repos**: Keep similar projects in the same config
3. **Use descriptive names**: Make it easy to identify repositories
4. **Consider local mirrors**: For frequently accessed large repositories
5. **Document access**: Keep track of which repos require special access

## See Also

- [Configuration](../getting-started/configuration.md) - General configuration
- [Usage Examples](../user-guide/usage-examples.md) - Real-world examples
- [Troubleshooting](../reference/troubleshooting.md) - Common issues
