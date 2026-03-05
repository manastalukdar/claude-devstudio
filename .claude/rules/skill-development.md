# Skill Development Rules

## Directory Structure

Each skill lives at `skills/<name>/SKILL.md`. Install copies to `~/.claude/skills/`.
Project-local agent/command utility skills live at `.claude/skills/<name>/SKILL.md`.

## YAML Frontmatter Fields

| Field | Required | Notes |
| --- | --- | --- |
| `name` | Yes | kebab-case, max 64 chars |
| `description` | Yes | Triggers auto-invocation; be specific and action-oriented |
| `disable-model-invocation` | Yes | `true` for side-effect skills (/commit, /deploy, /push) |
| `user-invocable` | No | Set `false` to hide from menu (agent/command-consumed skills) |
| `allowed-tools` | No | Restrict tool access per skill |
| `context` | No | `fork` to run skill in an isolated subagent |
| `agent` | No | Subagent type when `context: fork` |

## Skill Content Sections (in order)

1. **Purpose** — one-line description of what the skill does
2. **Usage** — invocation examples with arguments
3. **Behavior** — step-by-step what the skill does
4. **Examples** — concrete input/output examples
5. **Token Optimization** — expected token range and caching behavior
6. **Edge Cases** — known failure modes and how they are handled
7. **Safety** — any destructive operations and their safeguards

## Three-Tier Organization

- **Tier 1** (16 skills): High-impact, universally applicable, minimal setup required
- **Tier 2** (37 skills): Advanced features requiring some configuration or context
- **Tier 3** (16 skills): Power-user, specialized domain, or complex orchestration
- **Core** (30 skills): Foundational workflow skills used daily

## Naming Conventions

- kebab-case only: `api-test-generate`, not `apiTestGenerate` or `api_test_generate`
- Descriptive verb-noun: `debug-systematic`, `deploy-validate`, `session-start`
- No abbreviations unless industry-standard: `mcp-setup` (MCP is standard), not `mgr-setup`

## Token Optimization Checklist

Every new skill must include a "Token Optimization" section documenting:

- Expected token range: `N–M tokens` (initial call)
- Cache hit savings: what is cached and TTL
- Early exit conditions: when the skill returns immediately

Key patterns to apply:

1. **Grep-before-Read**: Search for patterns (100 tokens) before reading full files (2,000+ tokens) → 90-95% savings
2. **Early exit**: Check if work is already done before starting → 85-95% savings when condition met
3. **Progressive disclosure**: Return summary first, details only if requested → 60-85% savings
4. **Git diff scope**: Analyze `git diff --staged` by default, not entire codebase → 80-90% savings
5. **Bash for system queries**: `git log --oneline -10` vs reading files → 60-90% savings
6. **Caching**: Store results in `.claude/cache/<skill>/` with 7-day TTL → 70-99% on cache hits
7. **Template generation**: Use fixed templates vs LLM generation for scaffolding → 70-90% savings
8. **Glob for structure**: Pattern match before directory walks → 95% savings

## Per-Tier Token Budgets

| Tier | Initial Call | Cache Hit |
| --- | --- | --- |
| Tier 1 | 300–2,000 tokens | 50–200 tokens |
| Tier 2 | 500–4,000 tokens | 100–400 tokens |
| Tier 3 | 1,000–6,000 tokens | 200–600 tokens |
| Core | 300–1,500 tokens | 50–150 tokens |

## Quality Checklist Before Submitting a Skill

- Saves 5+ minutes of real developer work
- Works without project-specific configuration
- Handles edge cases gracefully (empty repo, no staged changes, etc.)
- Output is clear and actionable
- Under 100 lines of instructions (excluding frontmatter, code blocks, Token Optimization section)
- Includes YAML frontmatter with all required fields
- Token Optimization section present with concrete numbers
