# Changelog

All notable changes to git-reporter will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- MkDocs Material documentation site
- Comprehensive user guide and API documentation
- Support for local configuration files (`git-reporter.yaml`)
- Support for remote repository cloning
- Both `repos` and `repositories` field names in config (backward compatible)
- OpenAI and Gemini AI provider support
- Automatic cleanup of temporary directories for remote repos

### Changed
- Updated AI provider integration for pydantic-ai 1.31.0
- Config file priority: local configs override global config
- Improved error messages and user feedback

### Fixed
- pydantic-ai API compatibility issues
- Result access for AI-generated reports
- Environment variable handling for API keys

## [0.1.0] - 2024-12-14

### Added
- Initial release
- Multi-repository Git commit analysis
- AI-powered report generation
- Support for multiple time periods (daily, weekly, monthly, quarterly, yearly, custom)
- CLI interface with `init`, `add-repo`, `list-repos`, and `generate` commands
- OpenAI GPT integration
- Google Gemini integration
- Rich terminal output
- Export reports to markdown files
- Author email filtering
- Configuration management

### Security
- API keys stored in environment variables only
- No sensitive data in configuration files

[Unreleased]: https://github.com/shenxianpeng/git-reporter/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/shenxianpeng/git-reporter/releases/tag/v0.1.0
