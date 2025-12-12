# Quick Start Guide

Get started with git-reporter in 5 minutes!

## Installation

```bash
pip install git-reporter
```

## Setup (3 steps)

### 1. Initialize Configuration

```bash
git-reporter init
```

This creates `~/.git-reporter/config.yaml`

### 2. Add Your Repositories

```bash
git-reporter add-repo \
  --name my-project \
  --path ~/projects/my-project \
  --email your@email.com
```

Add as many repositories as you need!

### 3. Set Your API Key

Choose one AI provider and set its API key:

**For OpenAI (GPT):**
```bash
export OPENAI_API_KEY='sk-...'
```

**For Google Gemini:**
```bash
export GEMINI_API_KEY='AI...'
```

## Generate Your First Report

```bash
# Weekly report (default)
git-reporter generate

# Monthly report
git-reporter generate --period monthly

# Custom date range
git-reporter generate --period custom --start 2024-01-01 --end 2024-03-31

# Save to file
git-reporter generate --period weekly --output weekly-report.md
```

## Common Commands

```bash
# List configured repositories
git-reporter list-repos

# Add another repository
git-reporter add-repo --name another-project --path ~/projects/another

# Generate report for specific repos only
git-reporter generate --repo my-project --repo another-project

# Use different AI provider
git-reporter generate --provider gemini
```

## Example Configuration

Edit `~/.git-reporter/config.yaml`:

```yaml
ai_provider: openai
default_period: weekly
openai_model: gpt-4o-mini
repositories:
  - name: project1
    path: ~/projects/project1
    author_email: me@example.com
  - name: project2
    path: ~/projects/project2
```

## Getting API Keys

### OpenAI
1. Go to https://platform.openai.com/
2. Sign up/login
3. Navigate to API Keys
4. Create a new secret key
5. Set as environment variable: `export OPENAI_API_KEY='your-key'`

### Google Gemini
1. Go to https://aistudio.google.com/
2. Sign up/login
3. Click "Get API key"
4. Create a new API key
5. Set as environment variable: `export GEMINI_API_KEY='your-key'`

## Tips

- **Permanent API keys**: Add the export command to your `~/.bashrc` or `~/.zshrc`
- **Multiple repos**: Add all your work repositories for comprehensive reports
- **Author filtering**: Use `--email` to only include your commits
- **Save reports**: Use `--output` to save reports for later reference
- **Different periods**: Try different periods to see what works best for you

## Troubleshooting

**"Configuration file not found"**
- Run `git-reporter init` first

**"OpenAI/Gemini API key not configured"**
- Set the appropriate environment variable (see Setup step 3)

**"Not a valid git repository"**
- Check that the path in your config points to a valid git repository
- Use absolute paths or `~` for home directory

**No commits found**
- Check the author_email filter in your config
- Verify the date range matches when you made commits

## Next Steps

- Read the full [README.md](README.md) for detailed documentation
- Check [CONTRIBUTING.md](CONTRIBUTING.md) to contribute
- See [example-config.yaml](example-config.yaml) for configuration options

## Need Help?

- Open an issue: https://github.com/shenxianpeng/git-reporter/issues
- Read the docs: https://github.com/shenxianpeng/git-reporter

---

Happy reporting! 🎉
