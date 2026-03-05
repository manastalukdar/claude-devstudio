---
description: Orchestrate a full release — validate, generate changelog, bump version, and commit
argument-hint: "[patch|minor|major]"
---

# Release Workflow Command

Coordinate a complete release from validation to commit. Always asks for confirmation before destructive steps.

## Workflow

### Step 1: Determine Version Type

If `$ARGUMENTS` is provided and is one of `patch`, `minor`, or `major`, use it directly.

Otherwise, use the AskUserQuestion tool:

```
"What type of release is this? (patch / minor / major)"
```

### Step 2: Pre-flight Checks

Use the Skill tool to invoke `deploy-validate`:

```
Skill: deploy-validate
```

If validation fails with blocking issues, report them and stop. Ask the user to fix issues before retrying.

### Step 3: Generate Changelog

Use the Skill tool to invoke `changelog-auto`:

```
Skill: changelog-auto
```

Show the user a preview of the generated changelog entries.

### Step 4: Confirm Before Version Bump

Use the AskUserQuestion tool:

```
"Ready to bump version ($TYPE) and create release commit. Proceed? (yes/no)"
```

If the user says no, stop here with the changelog already updated.

### Step 5: Version Bump

Detect the project type and bump accordingly:

- **Node.js**: `Bash(npm version <type> --no-git-tag-version)`
- **Python**: Read `pyproject.toml` or `setup.py`, update version field
- **Rust**: Read `Cargo.toml`, update version field
- **Other**: Ask the user where the version is defined

### Step 6: Commit Release

Use the Skill tool to invoke `commit`:

```
Skill: commit
```

The commit message should follow the pattern: `chore(release): v<new-version>`

### Step 7: Summary

Report:

- New version number
- Changelog entries included
- Commit hash

## Critical Requirements

1. **Never push**: This command creates a local commit only — never `git push`
2. **Confirmation gates**: Steps 4 is a hard confirmation gate
3. **Never modify git config**: Use existing developer credentials only
4. **Rollback advice**: If anything fails after the version bump, advise: `git reset HEAD~1 --soft`
