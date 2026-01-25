# Migration Plan: Legacy Commands to Claude Skills Format

## Overview

Migrate from legacy `.claude/commands/*.md` format to new `.claude/skills/*/SKILL.md` format per Claude Code documentation.

## Current State (Legacy Format)

```
commands/
├── cleanproject.md
├── commit.md
├── contributing.md
... (29 files total)
```

## Target State (New Skills Format)

```
skills/
├── cleanproject/
│   └── SKILL.md
├── commit/
│   └── SKILL.md
├── contributing/
│   └── SKILL.md
... (29 directories, each with SKILL.md)
```

## Key Changes Required

### 1. File Structure
- **Old**: `commands/skill-name.md`
- **New**: `skills/skill-name/SKILL.md` (note: SKILL.md is uppercase)

### 2. Frontmatter Format

Each SKILL.md needs YAML frontmatter:

```yaml
---
name: skill-name
description: What the skill does and when to use it
disable-model-invocation: false  # true for manual-only skills
user-invocable: true            # false to hide from menu
---
```

### 3. Skill Categorization

Based on their nature, skills should have appropriate frontmatter:

#### User-Invoked Only (disable-model-invocation: true)
Skills with side effects that users should control:
- commit
- cleanproject
- scaffold
- undo
- session-start
- session-end
- session-update
- sessions-init
- todos-to-issues
- format

#### Auto-Invokable (disable-model-invocation: false)
Skills Claude can use automatically when relevant:
- review
- security-scan
- predict-issues
- understand
- explain-like-senior
- contributing
- test
- implement
- refactor
- fix-imports
- fix-todos
- find-todos
- create-todos
- remove-comments
- make-it-pretty
- docs

#### Session Management (special handling)
- session-help
- session-current
- session-list
- session-resume

## Migration Steps

### Phase 1: Create New Structure
1. Create `skills/` directory at project root
2. For each `.md` file in `commands/`:
   - Create `skills/{name}/` directory
   - Create `skills/{name}/SKILL.md`

### Phase 2: Add Frontmatter
For each skill, add appropriate frontmatter based on:
- Skill name (from filename)
- Description (craft from first paragraph or title)
- Invocation control (manual vs auto)
- User visibility (should it appear in menu?)

### Phase 3: Update Installation Scripts
- Modify `install.py` and `install.sh` to:
  - Copy from `skills/*/SKILL.md` to `~/.claude/skills/*/SKILL.md`
  - Maintain backward compatibility with `commands/` if needed
  - Update file count (29 skills)

### Phase 4: Update Documentation
- README.md: Update paths and structure references
- CLAUDE.md: Update file structure section
- AGENTS.md: Update skill development guidelines
- CONTRIBUTING.md: Update contribution instructions

### Phase 5: Testing
1. Test installation script on clean system
2. Verify skills appear in `/` menu
3. Test manual invocation of user-invocable skills
4. Test auto-invocation of model-invokable skills
5. Verify session management skills work correctly

## Backward Compatibility

The documentation states: "Your existing `.claude/commands/` files keep working"

We can:
1. Keep `commands/` directory for legacy support
2. Add deprecation notice in documentation
3. Recommend users migrate to new format
4. Support both formats in installation scripts temporarily

## Detailed Frontmatter Specifications

### Standard Frontmatter Template

```yaml
---
name: {skill-name}
description: {clear description of what it does and when to use it}
disable-model-invocation: {true|false}
user-invocable: {true|false}
allowed-tools: {optional - list of tools}
---
```

### Example: Commit Skill

```yaml
---
name: commit
description: Analyze changes and create meaningful conventional commits with pre-commit quality checks
disable-model-invocation: true
user-invocable: true
---
```

### Example: Review Skill

```yaml
---
name: review
description: Multi-agent code analysis covering security, performance, quality, and architecture. Use for comprehensive code reviews.
disable-model-invocation: false
user-invocable: true
---
```

### Example: Session-Help Skill

```yaml
---
name: session-help
description: Show help for the session management system with available commands and best practices
disable-model-invocation: false
user-invocable: true
---
```

## Skills with Special Considerations

### Skills with Subagents (context: fork)
Skills that should run in isolated subagent:
- review (if using multi-agent)
- security-scan (deep analysis)
- predict-issues (isolated analysis)
- understand (codebase exploration)

Add to frontmatter:
```yaml
context: fork
agent: Explore  # or Plan, general-purpose
```

### Skills with Validation Phases
Skills with validation commands:
- refactor (validate/finish/enhance/verify/complete)
- implement (validate)

Document these in skill content, not frontmatter.

### Skills with State Management
Skills that maintain session state:
- refactor (refactor/ folder)
- implement (implement/ folder)
- security-scan (security-scan/ folder)
- fix-imports (fix-imports/ folder)
- scaffold (scaffold/ folder)

## Risk Assessment

### Low Risk
- File structure changes (just renaming/moving)
- Adding frontmatter (additive change)
- Documentation updates

### Medium Risk
- Installation script changes (need thorough testing)
- Backward compatibility (need to verify both formats work)

### High Risk
- None identified (legacy format continues working)

## Success Criteria

1. ✅ All 29 skills migrated to new format
2. ✅ Installation scripts updated and tested
3. ✅ Documentation reflects new structure
4. ✅ Skills appear correctly in Claude Code CLI
5. ✅ Manual invocation works for all user-invocable skills
6. ✅ Auto-invocation works for model-invokable skills
7. ✅ Session management features functional
8. ✅ Backward compatibility maintained (optional)

## Timeline

1. **Phase 1-2**: Create structure and add frontmatter (1 hour)
2. **Phase 3**: Update installation scripts (30 minutes)
3. **Phase 4**: Update documentation (30 minutes)
4. **Phase 5**: Testing (30 minutes)

**Total estimated time**: 2.5-3 hours

## Next Steps

1. Review and approve this migration plan
2. Begin Phase 1: Create new directory structure
3. Proceed through phases systematically
4. Test thoroughly before committing
5. Update project version and changelog
