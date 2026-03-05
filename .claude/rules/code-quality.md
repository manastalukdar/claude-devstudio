# Code Quality Rules

## Language Standards

**Python** (install scripts, hooks):

- Follow PEP 8 style guide
- Use type hints for all function signatures
- f-strings over `.format()` or `%`-formatting
- Explicit error handling; never bare `except:`

**Shell scripts** (install.sh, uninstall.sh):

- Must pass `shellcheck` with no warnings
- Use `set -e` at the top
- Quote all variable expansions: `"${VAR}"` not `$VAR`
- Use `[[ ]]` for conditionals, not `[ ]`

**Markdown** (SKILL.md, docs):

- Consistent heading hierarchy (no skipped levels)
- Fenced code blocks with language identifier
- Tables aligned with spaces
- No trailing whitespace

## Communication Style

- No emoji in commits, skill output, or generated code
- No AI attribution in any generated content
- Concise and technical; senior developers prefer brevity over verbosity
- Output should be actionable, not explanatory

## File Operations

- **Always read a file before editing it** — never edit blind
- Use the `Edit` tool for modifying existing files (sends only the diff)
- Use the `Write` tool only for genuinely new files
- Never overwrite uncommitted work without a git checkpoint

## Install Script Sync Rule

When adding a new skill to `skills/`, verify the installers still work:

- `install.sh` and `uninstall.sh` use dynamic discovery — no manual array update needed
- `install.py` and `uninstall.py` use `Path.iterdir()` — no manual update needed
- Run `bash -n install.sh` and `python3 -m py_compile install.py` to verify syntax

When docs reference skill counts, update: `CLAUDE.md`, `AGENTS.md`, `README.md`.

## Anti-Patterns to Avoid

- Using AI credentials for git operations
- Committing without explicit user request
- Making destructive changes without git checkpoints
- Not reading files before editing them
- Over-engineering: adding abstractions for hypothetical future use
- Adding docstrings/comments to code that wasn't changed
- Creating helper utilities for one-time operations
- Adding error handling for scenarios that cannot happen
- Using feature flags or backwards-compat shims when you can just change the code

## Documentation Currency Rule

When modifying skill behavior, update the corresponding documentation in the same PR:

- Skill SKILL.md (primary)
- README.md skill listing if the skill description changed
- CLAUDE.md current state summary if skill counts changed
- AGENTS.md if the change affects agent workflows
