# Next Steps After PR Merge

This PR sets up the release infrastructure for the ioppub package. After this PR is merged to the `main` branch, follow these steps to create the first release (v0.1.0):

## Step 1: Ensure Main Branch is Up to Date

```bash
git checkout main
git pull origin main
```

## Step 2: Create the v0.1.0 Release

You have two options:

### Option A: Use the Helper Script (Recommended)

```bash
./create-release.sh 0.1.0
```

This script will:
- Check you're on the main branch (or warn if not)
- Verify the tag doesn't already exist
- Verify the CHANGELOG has an entry for v0.1.0
- Verify the version in typst.toml matches
- Create and push the tag

### Option B: Manual Tag Creation

```bash
git tag -a v0.1.0 -m "Release v0.1.0"
git push origin v0.1.0
```

## Step 3: Monitor the Release

After pushing the tag, the GitHub Actions workflow will automatically:
1. Extract the version from the tag
2. Extract the relevant changelog entries from CHANGELOG.md
3. Create a GitHub release with the changelog as release notes

Monitor the workflow at: https://github.com/munechika-koyo/ioppub/actions

## Step 4: Verify the Release

After the workflow completes, verify the release at:
https://github.com/munechika-koyo/ioppub/releases

The release should contain:
- Title: v0.1.0
- Tag: v0.1.0
- Release notes extracted from CHANGELOG.md

## Future Releases

For future releases, follow the process documented in [RELEASE.md](RELEASE.md):
1. Update the version in `typst.toml` and `README.md`
2. Add a new entry to `CHANGELOG.md`
3. Commit the changes
4. Create and push a tag using either the script or manual commands

## Publishing to Typst Package Registry

Note: This release creates a GitHub release. If you want to publish the package to the Typst package registry (@preview/ioppub), you'll need to follow the Typst package submission process separately. See: https://github.com/typst/packages
