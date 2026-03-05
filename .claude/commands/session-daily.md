---
description: Start your daily development session — shows git status, open TODOs, and health summary
argument-hint: "[session-name]"
---

# Daily Session Command

Begin a structured daily development session with full project health visibility.

## Workflow

### Step 1: Start Session

Use the Skill tool to invoke `session-start`:

```
Skill: session-start $ARGUMENTS
```

If `$ARGUMENTS` is empty, use the session name `daily-<YYYY-MM-DD>`.

### Step 2: Git Status Summary

Run these in sequence and report results:

```bash
Bash: git status --short
Bash: git log --oneline -5
Bash: git branch --show-current
```

Report:
- Current branch
- Modified/staged/untracked file counts
- Last 5 commits (one-line)

### Step 3: Open TODOs

Use the Skill tool to invoke `find-todos`:

```
Skill: find-todos
```

### Step 4: Project Health Check

Use the Skill tool to invoke `project-health` (project-local skill):

```
Skill: project-health
```

This checks for:
- Skill count consistency across documentation files
- Stale session files (>30 days old)
- Cache files that should be cleaned

### Step 5: Quick Security Pulse

Run a lightweight check (not the full scan):

```bash
Bash: git log --oneline --since="7 days ago" | grep -i "fix.*security\|patch.*vuln\|cve" || echo "No recent security commits"
```

### Step 6: Daily Briefing

Print a structured summary:

```
=== Daily Session: <date> ===
Branch: <branch>
Changes: <N modified, N staged, N untracked>
TODOs: <N open>
Health: <OK / N issues>
Security: <OK / check needed>

Session started. Use /session-update to track progress.
Use /session-end when done.
```

## Critical Requirements

1. **Read-only**: This command never modifies files
2. **Fast**: Should complete in under 30 seconds
3. **Non-blocking**: If any step fails, continue with the rest and note the failure
