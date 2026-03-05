# Git Workflow Rules

## ABSOLUTE RULE — Credentials

**NEVER use Claude or AI credentials for git commits.**

- All commits must use the developer's own configured git credentials
- Never add `Co-Authored-By: Claude` or any AI attribution to commits
- Never run `git config user.name` or `git config user.email` to set AI identity
- Never use `--author` flag to inject AI authorship

Violation of this rule is a critical security and attribution issue.

## Commit Message Format

Use conventional commits: `type(scope): description`

Allowed types: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `ci`, `perf`

Shorthand prefixes used in this project: `add:`, `fix:`, `docs:`

Examples:

```
feat(skills): add api-mock skill for stub server generation
fix(install): update skill list to dynamic discovery
docs(contributing): clarify tier assignment criteria
```

Rules:

- Subject line: max 72 characters, imperative mood, no period
- No emoji in commit messages
- No AI attribution in message body

## Git Checkpoint Rule

Before any destructive operation (file deletion, overwrite, reset), create a git checkpoint:

```bash
git add -A && git stash push -m "checkpoint before <operation>"
```

Recovery: `git stash pop`

## Never Commit Without Explicit User Request

Do not run `git commit` unless the user has explicitly asked for a commit.
Do not run `git push` unless the user has explicitly asked for a push.

Staging files for review is acceptable. Committing without permission is not.

## Branch Strategy

- `main`: primary stable branch; all PRs merge here
- `running`: author's daily driver; used as install.sh download source
- `add/feature-name`: contribution branches (new skill, fix, docs)

PR workflow: `add/feature-name` → PR → `main`

## Safe Rollback

Use the `/undo` skill to roll back with git checkpoints.
For dangerous operations, always verify with `git status` and `git diff` before proceeding.

## Worktree Usage for Parallel Development

Use git worktrees (via `/git-worktree` skill) for parallel development:

```bash
git worktree add ../feature-branch-name feature/branch-name
```

Each worktree runs an independent Claude Code session. Coordinate through the main branch merge.
