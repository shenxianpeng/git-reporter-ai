# Publishing git-reporter to PyPI

This guide explains how to publish git-reporter to PyPI.

## Prerequisites

1. Create accounts on:
   - [PyPI](https://pypi.org/) (for production releases)
   - [TestPyPI](https://test.pypi.org/) (for testing)

2. Install UV if not already installed:
   ```bash
   pip install uv
   ```

## Building the Package

1. Make sure all dependencies are installed:
   ```bash
   uv sync
   ```

2. Build the package:
   ```bash
   uv build
   ```

   This creates distribution files in the `dist/` directory:
   - `git_reporter-X.Y.Z.tar.gz` (source distribution)
   - `git_reporter-X.Y.Z-py3-none-any.whl` (wheel distribution)

## Testing the Package Locally

1. Install the package locally:
   ```bash
   pip install dist/git_reporter-0.1.0-py3-none-any.whl
   ```

2. Test the CLI:
   ```bash
   git-reporter --help
   ```

3. Uninstall after testing:
   ```bash
   pip uninstall git-reporter
   ```

## Publishing to TestPyPI (Recommended First)

1. Configure TestPyPI credentials:
   ```bash
   # Create ~/.pypirc file
   cat > ~/.pypirc << EOF
   [testpypi]
   username = __token__
   password = pypi-AgEIcHlwaS5vcmc... # Your TestPyPI API token
   EOF
   ```

2. Upload to TestPyPI:
   ```bash
   uv publish --index-url https://test.pypi.org/legacy/
   ```

3. Test installation from TestPyPI:
   ```bash
   pip install --index-url https://test.pypi.org/simple/ git-reporter
   ```

## Publishing to PyPI (Production)

1. Configure PyPI credentials:
   ```bash
   # Update ~/.pypirc file
   cat >> ~/.pypirc << EOF
   [pypi]
   username = __token__
   password = pypi-AgEIcHlwaS5vcmc... # Your PyPI API token
   EOF
   ```

2. Upload to PyPI:
   ```bash
   uv publish
   ```

3. Verify the upload:
   - Visit https://pypi.org/project/git-reporter/
   - Install and test:
     ```bash
     pip install git-reporter
     git-reporter --help
     ```

## Version Bumping

Before releasing a new version:

1. Update the version in `pyproject.toml`:
   ```toml
   version = "0.2.0"
   ```

2. Update the version in `src/git_reporter/__init__.py`:
   ```python
   __version__ = "0.2.0"
   ```

3. Update the CLI version in `src/git_reporter/cli.py`:
   ```python
   @click.version_option(version="0.2.0")
   ```

4. Commit the version change:
   ```bash
   git add pyproject.toml src/git_reporter/__init__.py src/git_reporter/cli.py
   git commit -m "Bump version to 0.2.0"
   git tag v0.2.0
   git push origin main --tags
   ```

5. Rebuild and publish:
   ```bash
   uv build
   uv publish
   ```

## Best Practices

1. **Always test on TestPyPI first** before publishing to production PyPI
2. **Use semantic versioning** (MAJOR.MINOR.PATCH)
3. **Create a git tag** for each release
4. **Update CHANGELOG** to document changes
5. **Clean the dist/ directory** before building a new version:
   ```bash
   rm -rf dist/
   uv build
   ```

## Troubleshooting

### "File already exists" error
This means you're trying to upload a version that already exists on PyPI. You must bump the version number.

### Authentication errors
Make sure your API token is correctly set in `~/.pypirc` and has the necessary permissions.

### Import errors after installation
This usually means there's a problem with the package structure. Verify:
- All `__init__.py` files exist in subdirectories
- The entry point in `pyproject.toml` is correct
- The package builds without errors

## Resources

- [PyPI Help](https://pypi.org/help/)
- [Python Packaging User Guide](https://packaging.python.org/)
- [UV Documentation](https://github.com/astral-sh/uv)
