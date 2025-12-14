# Troubleshooting

Common issues and solutions for git-reporter.

## Installation Issues

### Command Not Found

**Problem**: `git-reporter: command not found` after installation

**Solutions**:

1. Add Python scripts directory to PATH:
   ```bash
   # Linux/Mac
   export PATH="$HOME/.local/bin:$PATH"
   
   # Windows
   $env:Path += ";$HOME\AppData\Roaming\Python\Scripts"
   ```

2. Reinstall with user flag:
   ```bash
   pip install --user git-reporter
   ```

3. Use full path:
   ```bash
   python -m git_reporter.cli generate
   ```

### Python Version Error

**Problem**: Requires Python 3.12+

**Solution**: Upgrade Python:
```bash
python --version  # Check current version
# Install Python 3.12+ from python.org
```

## Configuration Issues

### Configuration File Not Found

**Problem**: `Configuration file not found`

**Solutions**:

1. Initialize configuration:
   ```bash
   git-reporter init
   ```

2. Create local config:
   ```bash
   touch git-reporter.yaml
   # Edit with your settings
   ```

3. Specify config file:
   ```bash
   git-reporter generate --config /path/to/config.yaml
   ```

### Invalid Configuration

**Problem**: `Invalid configuration` error

**Solutions**:

1. Check YAML syntax:
   ```bash
   # Use online YAML validator or:
   python -c "import yaml; yaml.safe_load(open('git-reporter.yaml'))"
   ```

2. Verify required fields:
   - `ai_provider` must be present
   - At least one repository required
   - Each repo needs `name` and either `path` or `repo`

3. Check [Configuration Schema](config-schema.md)

## API Key Issues

### OpenAI API Key Not Configured

**Problem**: `OpenAI API key not configured`

**Solutions**:

1. Set environment variable:
   ```bash
   export OPENAI_API_KEY='sk-...'
   ```

2. Make it permanent:
   ```bash
   echo 'export OPENAI_API_KEY="sk-..."' >> ~/.bashrc
   source ~/.bashrc
   ```

3. Verify it's set:
   ```bash
   echo $OPENAI_API_KEY
   ```

### Gemini API Key Not Configured

**Problem**: `Gemini API key not configured`

**Solutions**: Same as OpenAI, but use `GEMINI_API_KEY`

### Invalid API Key

**Problem**: API authentication failed

**Solutions**:

1. Verify key is correct
2. Check key hasn't expired
3. Verify you have API access enabled

## Repository Issues

### Not a Valid Git Repository

**Problem**: `Not a valid git repository: /path/to/repo`

**Solutions**:

1. Verify path is correct:
   ```bash
   ls -la /path/to/repo/.git
   ```

2. Initialize Git if needed:
   ```bash
   cd /path/to/repo
   git init
   ```

3. Use absolute path:
   ```yaml
   repos:
     - name: myrepo
       path: /full/path/to/repo  # Not relative path
   ```

### Failed to Clone Repository

**Problem**: Remote repository clone failed

**Solutions**:

1. Check URL is correct
2. Verify network connectivity
3. Check authentication:
   ```bash
   git clone https://github.com/user/repo.git /tmp/test
   ```

4. For private repos, set up credentials:
   ```bash
   git config --global credential.helper store
   ```

### No Commits Found

**Problem**: Report shows no commits

**Solutions**:

1. Check date range:
   ```bash
   # Use custom period to verify commits exist
   git-reporter generate --period custom --start 2024-01-01 --end 2024-12-31
   ```

2. Check author email filter:
   ```yaml
   repos:
     - name: myrepo
       path: ~/projects/myrepo
       # Remove or update author_email
   ```

3. Verify commits exist:
   ```bash
   cd /path/to/repo
   git log --since="1 week ago"
   ```

## Report Generation Issues

### AI Provider Errors

**Problem**: Errors from AI provider

**Solutions**:

1. Check API key is valid
2. Verify account has credits/quota
3. Try different provider:
   ```bash
   git-reporter generate --provider gemini
   ```

4. Check rate limits (wait and retry)

### Report Takes Too Long

**Problem**: Report generation is slow

**Causes & Solutions**:

1. **Large repository**: Remote clone is slow
   - Solution: Use local clone instead
   
2. **Many commits**: Processing takes time
   - Solution: Use shorter time periods
   
3. **Multiple repositories**: Sequential processing
   - Solution: Generate for specific repos only:
     ```bash
     git-reporter generate --repo frontend
     ```

### Empty or Poor Quality Reports

**Problem**: Generated report is not useful

**Solutions**:

1. Use better AI model:
   ```yaml
   ai_provider: openai
   openai_model: gpt-4o  # Instead of gpt-4o-mini
   ```

2. Ensure enough commits in period
3. Check commit messages are descriptive

## Permission Issues

### Permission Denied

**Problem**: Cannot write to config directory

**Solutions**:

1. Use local config instead:
   ```bash
   # Instead of git-reporter init
   touch git-reporter.yaml
   ```

2. Fix permissions:
   ```bash
   chmod 755 ~/.git-reporter
   chmod 644 ~/.git-reporter/config.yaml
   ```

### Cannot Access Repository

**Problem**: Permission denied accessing repository

**Solutions**:

1. Check file permissions:
   ```bash
   ls -ld /path/to/repo
   ```

2. For remote repos, set up authentication

## Advanced Issues

### Memory Issues

**Problem**: Out of memory errors

**Solutions**:

1. Process fewer repositories at once
2. Use specific repo filter:
   ```bash
   git-reporter generate --repo specific-repo
   ```

### Network Issues

**Problem**: Network timeouts or connection errors

**Solutions**:

1. Check internet connection
2. Verify proxy settings
3. Use local repositories if available

### Cleanup Issues

**Problem**: Temporary directories not cleaned up

**Solution**: Manual cleanup:
```bash
# Linux/Mac
rm -rf /tmp/git-reporter-*

# Windows
del /s /q %TEMP%\git-reporter-*
```

## Getting Help

If these solutions don't help:

1. Check [GitHub Issues](https://github.com/shenxianpeng/git-reporter/issues)
2. Search [Discussions](https://github.com/shenxianpeng/git-reporter/discussions)
3. Create a new issue with:
   - git-reporter version
   - Python version
   - Operating system
   - Full error message
   - Configuration (without API keys)

## Debug Mode

For detailed error information:

```bash
# Increase verbosity
git-reporter generate --period weekly 2>&1 | tee debug.log
```

## See Also

- [Configuration Guide](../getting-started/configuration.md)
- [CLI Commands](../user-guide/cli-commands.md)
- [Installation](../getting-started/installation.md)
