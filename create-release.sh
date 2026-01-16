#!/bin/bash
# Script to create a new release
# Usage: ./create-release.sh X.Y.Z

set -e

if [ $# -ne 1 ]; then
    echo "Usage: $0 X.Y.Z"
    echo "Example: $0 0.1.0"
    exit 1
fi

VERSION=$1
TAG="v${VERSION}"

echo "Creating release ${TAG}..."

# Check if we're on main branch
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo "Warning: Not on main branch (current: ${CURRENT_BRANCH})"
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Check if tag already exists
if git rev-parse "$TAG" >/dev/null 2>&1; then
    echo "Error: Tag ${TAG} already exists"
    exit 1
fi

# Check if CHANGELOG has entry for this version
if ! grep -q "## \[${VERSION}\]" CHANGELOG.md; then
    echo "Error: CHANGELOG.md does not contain entry for version ${VERSION}"
    echo "Please add a changelog entry for this version"
    exit 1
fi

# Check if version in typst.toml matches
TOML_VERSION=$(grep '^version = ' typst.toml | cut -d'"' -f2)
if [ "$TOML_VERSION" != "$VERSION" ]; then
    echo "Error: Version in typst.toml (${TOML_VERSION}) does not match ${VERSION}"
    echo "Please update typst.toml"
    exit 1
fi

# Create and push tag
echo "Creating tag ${TAG}..."
git tag -a "$TAG" -m "Release ${TAG}"

echo "Pushing tag to remote..."
git push origin "$TAG"

echo ""
echo "✅ Tag ${TAG} created and pushed successfully!"
echo "The GitHub Actions workflow will automatically create the release."

# Extract GitHub URL from git remote
REPO_URL=$(git config --get remote.origin.url | sed 's/\.git$//')
# Convert SSH URL to HTTPS if needed
REPO_URL=$(echo "$REPO_URL" | sed 's/^git@github\.com:/https:\/\/github.com\//')
echo "Monitor the workflow at: ${REPO_URL}/actions"
