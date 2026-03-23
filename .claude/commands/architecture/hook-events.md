# Hook Events Architecture Reference

Invoke this command mid-session to restore the full hook system reference without re-reading settings.json or AGENTS.md.

---

## All 19 Hook Events

| Event | Trigger | `once` |
| --- | --- | --- |
| `PreToolUse` | Before any tool call | No |
| `PostToolUse` | After successful tool call | No |
| `PostToolUseFailure` | After failed tool call | No |
| `PermissionRequest` | When Claude requests permission | No |
| `UserPromptSubmit` | When user submits a message | No |
| `Notification` | On notification events | No |
| `Stop` | When Claude stops responding | No |
| `SubagentStart` | When a subagent starts | No |
| `SubagentStop` | When a subagent stops | No |
| `PreCompact` | Before context compaction | Yes |
| `SessionStart` | When a session begins | Yes |
| `SessionEnd` | When a session ends | Yes |
| `Setup` | On initial setup | Yes |
| `TeammateIdle` | When a teammate goes idle | No |
| `TaskCompleted` | When a task completes | No |
| `ConfigChange` | On configuration change | No |
| `WorktreeCreate` | When a worktree is created | No |
| `WorktreeRemove` | When a worktree is removed | No |
| `InstructionsLoaded` | When instructions are loaded | No |

## Settings.json Hook Structure

```json
"hooks": {
  "SessionStart": [
    {
      "hooks": [{ "type": "command", "command": "...", "timeout": 5000, "async": true, "once": true }]
    },
    {
      "matcher": "compact",
      "hooks": [{ "type": "command", "command": "...", "timeout": 5000 }]
    }
  ]
}
```

- `matcher` — filters which events in the category trigger the hook (e.g., `"compact"` for post-compaction SessionStart)
- `once` — fires only once per session
- `async: true` — hook runs asynchronously (does not block Claude)
- `timeout` — milliseconds before hook is killed

## DevStudio Hook Script

**`hooks.py`** handles all 19 events:

- Reads event name from `CLAUDE_HOOK_EVENT` env var
- Reads payload JSON from stdin
- Logs to `.claude/hooks/hooks-log.jsonl`
- Plays audio notification if a sound file is configured in `.claude/hooks/sounds/`
- Accepts `--agent=<name>` for agent-specific behavior

**Sound map** (place `.wav`/`.mp3`/`.ogg` in `.claude/hooks/sounds/`):

| Event | Sound file |
| --- | --- |
| SessionStart | `session-start` |
| SessionEnd | `session-end` |
| TaskCompleted | `task-complete` |
| PostToolUseFailure | `error` |
| Stop | `stop` |
| PreCompact | `compact` |
| SubagentStart | `subagent-start` |
| SubagentStop | `subagent-stop` |
| WorktreeCreate | `worktree-create` |
| WorktreeRemove | `worktree-remove` |

**Bash sound overrides** (matched against the command string):

| Pattern | Sound |
| --- | --- |
| `git commit` | `commit` |
| `git push` | `push` |
| `git merge` | `merge` |
| `npm test` / `pytest` / `cargo test` | `test-run` |

## Compact Reminder Hook

**`compact-reminder.py`** fires on `SessionStart` with `matcher: "compact"`:

- Outputs a structured codebase reminder to stdout
- Claude Code injects this as a system message to restore critical context lost during compaction
- Covers: project identity, safety rules, key directories, skill development rules, token optimization, commit format

## Agent-Level Hooks

Agents define per-agent hooks in YAML frontmatter:

```yaml
hooks:
  PostToolUse:
    - matcher: ".*"
      hooks:
        - type: command
          command: python3 ${CLAUDE_PROJECT_DIR}/.claude/hooks/scripts/hooks.py --agent=<name>
          timeout: 5000
          async: true
```
