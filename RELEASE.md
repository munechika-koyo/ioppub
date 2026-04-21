# Release Process

This document describes how to create a new release of the ioppub package.

## Overview

The release process is automated using GitHub Actions. When you push a tag with the format `vX.Y.Z`, a GitHub workflow will automatically create a release with the corresponding changelog entries.

## Creating a Release

**Important:** Releases should be created from the `main` branch. Ensure all changes are merged to `main` before creating a release.

### 1. Update the Version

Before creating a release, ensure the version is updated in the following files:

- `typst.toml`: Update the `version` field
- `README.md`: Update the version badge and import statement

### 2. Update the Changelog

Add an entry to `CHANGELOG.md` following the [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format:

```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- New features

### Changed
- Changes to existing functionality

### Deprecated
- Soon-to-be removed features

### Removed
- Removed features

### Fixed
- Bug fixes

### Security
- Security fixes

[X.Y.Z]: https://github.com/munechika-koyo/ioppub/releases/tag/vX.Y.Z
```

### 3. Commit Changes

Commit the version updates and changelog:

```bash
git add typst.toml README.md CHANGELOG.md
git commit -m "Release vX.Y.Z"
git push
```

### 4. Create and Push Tag

You can use the provided script to create and push a tag:

```bash
./create-release.sh X.Y.Z
```

Or manually create a git tag for the release:

```bash
git tag -a vX.Y.Z -m "Release vX.Y.Z"
git push origin vX.Y.Z
```

### 5. Automated Release

The GitHub Actions workflow (`.github/workflows/release.yml`) will automatically:
- Extract the version from the tag
- Extract the relevant changelog entries
- Create a GitHub release with the changelog as release notes

## Version Numbering

This project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html):

- **MAJOR** version for incompatible API changes
- **MINOR** version for added functionality in a backwards compatible manner
- **PATCH** version for backwards compatible bug fixes

## Manual Release (if needed)

If the automated workflow fails or you need to create a release manually:

1. Go to https://github.com/munechika-koyo/ioppub/releases/new
2. Choose the tag `vX.Y.Z`
3. Set the release title to `vX.Y.Z`
4. Copy the relevant section from `CHANGELOG.md` to the release description
5. Click "Publish release"
