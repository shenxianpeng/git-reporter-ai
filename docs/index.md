# Welcome to git-reporter

<div align="center">
  <h1>🚀 git-reporter</h1>
  <p><strong>AI-Powered Git Commit History Analyzer and Report Generator</strong></p>
  
  <p>
    <a href="https://github.com/shenxianpeng/git-reporter/blob/main/LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-yellow.svg"></a>
    <a href="https://www.python.org/downloads/"><img alt="Python 3.12+" src="https://img.shields.io/badge/python-3.12+-blue.svg"></a>
    <a href="https://github.com/shenxianpeng/git-reporter"><img alt="GitHub Stars" src="https://img.shields.io/github/stars/shenxianpeng/git-reporter?style=social"></a>
  </p>
</div>

## 📖 Overview

`git-reporter` is a powerful Python tool that analyzes your Git commit history across multiple repositories and uses AI to generate professional work reports. Perfect for developers who need to create weekly, monthly, quarterly, or yearly reports for their managers without maintaining daily logs.

## ✨ Key Features

- 📊 **Multi-Repository Analysis**: Analyze commits from multiple Git repositories simultaneously
- 🌐 **Remote & Local Repos**: Support both local and remote (GitHub, GitLab, etc.) repositories
- 🤖 **AI-Powered Reports**: Generate intelligent summaries using OpenAI GPT or Google Gemini
- ⏰ **Flexible Time Periods**: Support for daily, weekly, monthly, quarterly, yearly, and custom date ranges
- 🎯 **Author Filtering**: Filter commits by specific author email addresses
- 🔧 **Easy Configuration**: Simple YAML-based configuration with local or global config files
- 🎨 **Rich CLI Interface**: Beautiful command-line interface with progress indicators
- 📝 **Export Reports**: Save reports to markdown files
- 🔒 **Secure**: API keys stored in environment variables, not in config files
- 📂 **Local Config Priority**: Project-level `git-reporter.yaml` takes priority over global config

## 🎯 Perfect For

- **Individual Developers**: Generate weekly/monthly reports for your manager
- **Team Leads**: Track team contributions across multiple projects
- **Open Source Contributors**: Summarize your contributions across repositories
- **Consultants**: Create client reports from your work across different projects

## 🚀 Quick Example

```bash
# Generate a weekly report
git-reporter generate --period weekly

# Generate a monthly report for specific repos
git-reporter generate --period monthly --repo project1 --repo project2 --output report.md
```

## 🛠️ Technologies

Built with modern Python tools:

- **UV**: Modern Python package manager for fast dependency management
- **Pydantic**: Data validation using Python type annotations
- **Pydantic-AI**: AI model abstraction layer for easy integration with multiple providers
- **GitPython**: Git repository interaction
- **Click**: Command-line interface creation
- **Rich**: Beautiful terminal output

## 📚 Documentation Structure

<div class="grid cards" markdown>

-   :material-clock-fast:{ .lg .middle } __Quick Start__

    ---

    Get up and running in 5 minutes with our quick start guide

    [:octicons-arrow-right-24: Quick Start](getting-started/quickstart.md)

-   :material-book-open-variant:{ .lg .middle } __User Guide__

    ---

    Comprehensive guides for all features and use cases

    [:octicons-arrow-right-24: User Guide](user-guide/cli-commands.md)

-   :material-cog:{ .lg .middle } __Configuration__

    ---

    Learn how to configure git-reporter for your needs

    [:octicons-arrow-right-24: Configuration](getting-started/configuration.md)

-   :material-code-braces:{ .lg .middle } __Development__

    ---

    Contributing guidelines and development setup

    [:octicons-arrow-right-24: Contributing](development/contributing.md)

</div>

## 🎥 Demo

```yaml title="git-reporter.yaml"
ai_provider: openai
default_period: weekly
openai_model: gpt-4o-mini
repos:
  # Local repository
  - name: my-project
    path: ~/projects/my-project
    author_email: you@example.com
  
  # Remote repository (auto-cloned)
  - name: github-project
    repo: https://github.com/username/repo.git
    author_email: you@example.com
```

## 🤝 Support

- 📖 Read the [Documentation](getting-started/quickstart.md)
- 🐛 Report issues on [GitHub](https://github.com/shenxianpeng/git-reporter/issues)
- 💬 Ask questions in [Discussions](https://github.com/shenxianpeng/git-reporter/discussions)

## 📝 License

This project is licensed under the MIT License - see the [License](about/license.md) page for details.

---

<div align="center">
  <p>Made with ❤️ by <a href="https://github.com/shenxianpeng">Xianpeng Shen</a></p>
  <p>⭐ Star us on <a href="https://github.com/shenxianpeng/git-reporter">GitHub</a> if you find this useful!</p>
</div>
