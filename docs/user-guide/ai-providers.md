# AI Providers

git-reporter supports multiple AI providers for generating report summaries.

## Supported Providers

### OpenAI

OpenAI's GPT models are known for their high quality and consistency.

#### Models

| Model | Description | Speed | Cost | Recommended |
|-------|-------------|-------|------|-------------|
| `gpt-4o` | Most capable model | Medium | High | For best quality |
| `gpt-4o-mini` | Fast and cost-effective | Fast | Low | **Default** ⭐ |
| `gpt-4-turbo` | Previous generation | Medium | Medium | Legacy support |
| `gpt-3.5-turbo` | Older model | Fast | Low | Budget option |

#### Setup

1. Get your API key from [OpenAI Platform](https://platform.openai.com/)
2. Set the environment variable:

```bash
export OPENAI_API_KEY='sk-...'
```

3. Configure in your config file:

```yaml
ai_provider: openai
openai_model: gpt-4o-mini
```

### Google Gemini

Google's Gemini models offer great performance and competitive pricing.

#### Models

| Model | Description | Speed | Cost | Recommended |
|-------|-------------|-------|------|-------------|
| `gemini-2.0-flash-exp` | Latest experimental | Very Fast | Low | **Default** ⭐ |
| `gemini-1.5-pro` | Production-ready pro model | Medium | Medium | For complex reports |
| `gemini-1.5-flash` | Fast and efficient | Fast | Low | Good balance |

#### Setup

1. Get your API key from [Google AI Studio](https://aistudio.google.com/)
2. Set the environment variable:

```bash
export GEMINI_API_KEY='AI...'
```

3. Configure in your config file:

```yaml
ai_provider: gemini
gemini_model: gemini-2.0-flash-exp
```

## Choosing a Provider

### OpenAI

**Best for:**

- Enterprise use cases
- Consistent, high-quality output
- Complex report requirements
- When you already have OpenAI infrastructure

**Pros:**

- ✅ Excellent quality and consistency
- ✅ Well-established and reliable
- ✅ Good documentation and support
- ✅ Multiple model options

**Cons:**

- ❌ Higher cost than Gemini
- ❌ Requires OpenAI account

### Google Gemini

**Best for:**

- High-volume report generation
- Cost-sensitive use cases
- When speed is important
- Google ecosystem integration

**Pros:**

- ✅ Very fast response times
- ✅ Lower cost
- ✅ Good quality output
- ✅ Free tier available

**Cons:**

- ❌ Newer, less established
- ❌ Some experimental models

## Switching Providers

You can switch providers at any time:

### Via Configuration

Edit your config file:

```yaml
# Switch to OpenAI
ai_provider: openai
openai_model: gpt-4o-mini

# Or switch to Gemini
ai_provider: gemini
gemini_model: gemini-2.0-flash-exp
```

### Via Command Line

Override the configured provider:

```bash
# Use Gemini for this report
git-reporter generate --provider gemini

# Use OpenAI for this report
git-reporter generate --provider openai
```

## API Key Management

### Security Best Practices

!!! warning "Never commit API keys"
    - ❌ Don't put API keys in config files
    - ❌ Don't commit API keys to version control
    - ✅ Always use environment variables
    - ✅ Use secret management tools in CI/CD

### Setting API Keys

#### Temporary (Current Session)

```bash
export OPENAI_API_KEY='your-key'
export GEMINI_API_KEY='your-key'
```

#### Permanent

Add to your shell configuration:

=== "Bash"
    ```bash
    echo 'export OPENAI_API_KEY="your-key"' >> ~/.bashrc
    source ~/.bashrc
    ```

=== "Zsh"
    ```bash
    echo 'export OPENAI_API_KEY="your-key"' >> ~/.zshrc
    source ~/.zshrc
    ```

=== "Fish"
    ```fish
    echo 'set -gx OPENAI_API_KEY "your-key"' >> ~/.config/fish/config.fish
    source ~/.config/fish/config.fish
    ```

=== "Windows PowerShell"
    ```powershell
    [System.Environment]::SetEnvironmentVariable('OPENAI_API_KEY', 'your-key', 'User')
    ```

### Multiple API Keys

You can have both providers configured:

```bash
export OPENAI_API_KEY='sk-...'
export GEMINI_API_KEY='AI...'
```

Then switch between them as needed:

```bash
# Use OpenAI
git-reporter generate --provider openai

# Use Gemini
git-reporter generate --provider gemini
```

## Cost Comparison

Approximate costs for a typical monthly report (assuming ~10,000 tokens):

| Provider | Model | Estimated Cost |
|----------|-------|----------------|
| OpenAI | gpt-4o | $0.30 |
| OpenAI | gpt-4o-mini | $0.03 |
| OpenAI | gpt-3.5-turbo | $0.02 |
| Gemini | gemini-1.5-pro | $0.05 |
| Gemini | gemini-2.0-flash-exp | $0.01 |

!!! info "Actual costs may vary"
    Costs depend on report length, commit count, and model pricing changes.

## Performance Comparison

Typical response times for generating a weekly report with ~50 commits:

| Provider | Model | Response Time |
|----------|-------|---------------|
| OpenAI | gpt-4o | ~5-10s |
| OpenAI | gpt-4o-mini | ~2-5s |
| Gemini | gemini-2.0-flash-exp | ~1-3s |
| Gemini | gemini-1.5-flash | ~2-4s |

## Troubleshooting

### OpenAI Issues

#### Invalid API Key

```
Error: OpenAI API key not configured
```

**Solution**: Set the environment variable:

```bash
export OPENAI_API_KEY='your-key'
```

#### Rate Limit Exceeded

```
Error: Rate limit exceeded
```

**Solution**: 
- Wait a few minutes and try again
- Upgrade your OpenAI plan
- Switch to Gemini temporarily

### Gemini Issues

#### Invalid API Key

```
Error: Gemini API key not configured
```

**Solution**: Set the environment variable:

```bash
export GEMINI_API_KEY='your-key'
```

#### API Not Enabled

**Solution**: Enable the Gemini API in your Google Cloud project.

## Future Providers

We plan to add support for:

- [ ] Anthropic Claude
- [ ] Azure OpenAI
- [ ] Local models (Ollama, LLaMA)
- [ ] AWS Bedrock

Stay tuned for updates!

## See Also

- [Configuration](../getting-started/configuration.md) - Configure AI providers
- [CLI Commands](cli-commands.md) - Override providers via CLI
- [Troubleshooting](../reference/troubleshooting.md) - Common issues
