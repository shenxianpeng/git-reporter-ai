.DEFAULT_GOAL := help
sources = src

.PHONY: .uv  ## Check that uv is installed
.uv:
	@uv -V || echo 'Please install uv: https://docs.astral.sh/uv/getting-started/installation/'

.PHONY: install  ## Install the package and dependencies for local development
install: .uv
	uv sync --all-extras

.PHONY: install-dev  ## Install with development dependencies
install-dev: .uv
	uv sync --extra dev --extra docs

.PHONY: update  ## Update dependencies
update: .uv
	uv lock --upgrade

.PHONY: format  ## Auto-format python source files
format: .uv
	uv run --extra dev ruff check --fix $(sources)
	uv run --extra dev ruff format $(sources)

.PHONY: lint  ## Lint python source files
lint: .uv
	uv run --extra dev ruff check $(sources)
	uv run --extra dev ruff format --check $(sources)

.PHONY: test  ## Run all tests
test: .uv
	uv run --extra dev pytest tests/ -v

.PHONY: test-cov  ## Run tests and generate a coverage report
test-cov: .uv
	uv run --extra dev pytest tests/ --cov=src/git_reporter --cov-report=html --cov-report=term

.PHONY: clean  ## Clear local caches and build artifacts
clean:
	rm -rf `find . -name __pycache__`
	rm -f `find . -type f -name '*.py[co]'`
	rm -f `find . -type f -name '*~'`
	rm -f `find . -type f -name '.*~'`
	rm -rf .cache
	rm -rf .pytest_cache
	rm -rf .ruff_cache
	rm -rf htmlcov
	rm -rf *.egg-info
	rm -f .coverage
	rm -f .coverage.*
	rm -rf build
	rm -rf dist
	rm -rf site
	rm -rf coverage.xml

.PHONY: docs  ## Build the documentation
docs: .uv
	uv run --extra docs mkdocs build

.PHONY: docs-serve  ## Build and serve the documentation for local preview
docs-serve: .uv
	uv run --extra docs mkdocs serve

.PHONY: docs-deploy  ## Deploy documentation to GitHub Pages
docs-deploy: .uv
	uv run --extra docs mkdocs gh-deploy --force

.PHONY: build  ## Build the package
build: .uv
	uv build

.PHONY: publish  ## Publish the package to PyPI
publish: .uv
	uv publish

.PHONY: run  ## Run git-reporter CLI (use ARGS="..." to pass arguments)
run: .uv
	uv run git-reporter $(ARGS)

.PHONY: check  ## Run format and lint checks
check: format lint

.PHONY: all  ## Run format, lint, and test
all: check test

.PHONY: help  ## Display this message
help:
	@grep -E \
		'^.PHONY: .*?## .*$$' $(MAKEFILE_LIST) | \
		sort | \
		awk 'BEGIN {FS = ".PHONY: |## "}; {printf "\033[36m%-19s\033[0m %s\n", $$2, $$3}'