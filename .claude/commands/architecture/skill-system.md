# Skill System Architecture Reference

Invoke this command mid-session to restore the full skill system reference without re-reading all rule files.

---

## Three-Tier Organization

| Tier | Count | Characteristics |
| --- | --- | --- |
| Tier 1 | 16 | High-impact, universally applicable, minimal setup |
| Tier 2 | 37 | Advanced features, some configuration or context required |
| Tier 3 | 16 | Power-user, specialized domain, complex orchestration |
| Core | 30 | Foundational daily-driver skills |
| **Total** | **99** | |

## Directory Layout

```
skills/
  <name>/
    SKILL.md          ← user-invocable skills (installed to ~/.claude/skills/)

.claude/skills/
  <name>/
    SKILL.md          ← project-local agent/command utility skills (not user-invocable)
```

## YAML Frontmatter Fields

| Field | Required | Notes |
| --- | --- | --- |
| `name` | Yes | kebab-case, max 64 chars |
| `description` | Yes | Used for auto-invocation; be specific and action-oriented |
| `disable-model-invocation` | Yes | `true` for side-effect skills (/commit, /deploy, /push) |
| `user-invocable` | No | `false` to hide from menu (agent/command-consumed skills) |
| `allowed-tools` | No | Restrict tool access |
| `context` | No | `fork` to run in isolated subagent |
| `agent` | No | Subagent type when `context: fork` |

## Required SKILL.md Sections (in order)

1. **Purpose** — one-line description
2. **Usage** — invocation examples with arguments
3. **Behavior** — step-by-step what the skill does
4. **Examples** — concrete input/output examples
5. **Token Optimization** — expected token range, caching, early exit
6. **Edge Cases** — known failure modes and handling
7. **Safety** — destructive operations and safeguards

## Naming Conventions

- kebab-case only: `api-test-generate`, not `apiTestGenerate`
- Descriptive verb-noun: `debug-systematic`, `deploy-validate`, `session-start`
- No abbreviations unless industry-standard (e.g., `mcp-setup` is fine)

## Token Budgets

| Tier | Target Range | Acceptable Max |
| --- | --- | --- |
| Core | 300–1,500 | 3,000 |
| Tier 1 | 300–2,000 | 4,000 |
| Tier 2 | 500–4,000 | 8,000 |
| Tier 3 | 1,000–6,000 | 12,000 |

## Token Optimization Patterns

1. **Grep-before-Read** — search (100 tokens) before reading full files (2000+) → 85–95% savings
2. **Glob for structure** — pattern match before directory walks → 95% savings
3. **Early exit** — check preconditions before doing work → 85–95% when condition met
4. **Progressive disclosure** — summary first, details on request → 60–85% savings
5. **Git diff scope** — default to `git diff --staged`, not full codebase → 80–90% savings
6. **Bash for system queries** — `node -p "require('./package.json').version"` vs Read → 60–90%
7. **Caching** — `.claude/cache/<skill-name>/` with 7-day TTL → 70–99% on cache hits
8. **Template generation** — fixed templates with variable substitution → 70–90% savings

## Quality Checklist for New Skills

- Saves 5+ minutes of real developer work
- Works without project-specific configuration
- Handles edge cases gracefully (empty repo, no staged changes, etc.)
- Output is clear and actionable
- Under 100 lines of instructions (excluding frontmatter, code blocks, Token Optimization)
- YAML frontmatter with all required fields
- Token Optimization section with concrete numbers

## Install Script Sync Rule

`install.sh`, `uninstall.sh`, `install.py`, `uninstall.py` all use **dynamic discovery** — no manual array updates needed when adding skills. Verify: `bash -n install.sh` and `python3 -m py_compile install.py`.

When adding a skill, update skill counts in: `CLAUDE.md`, `AGENTS.md`, `README.md`.
