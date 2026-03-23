# Code Reviewer — Institutional Memory

This file is loaded into the agent's context on every invocation. It records
recurring patterns, anti-patterns, and codebase-specific findings that improve
future reviews. The agent may append to this file after completing a review.

## Project-Specific Patterns

- Skills are markdown files — review for correct YAML frontmatter structure
  (required fields: name, description, disable-model-invocation) and required
  sections (Purpose, Usage, Behavior, Examples, Token Optimization, Edge Cases, Safety).
- Install scripts (`install.sh`, `install.py`, `uninstall.sh`, `uninstall.py`) use
  dynamic skill discovery — no hardcoded arrays. Shell scripts must pass `shellcheck`.
- Python scripts must follow PEP 8, use type hints, and use f-strings.
- No emoji in any file. No AI attribution in any generated content.
- Token optimization patterns must be present in every new SKILL.md.

## Review History

_Append codebase-specific findings here after reviews that surface recurring patterns._
