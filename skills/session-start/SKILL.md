---
name: session-start
description: Begin documented development session using Claude Code CLI's memory system
disable-model-invocation: true
---

# Start Development Session

I'll begin a documented coding session using Claude Code CLI's memory system.

I'll integrate with the native memory system by creating a session file in `.claude/sessions/` with the format `YYYY-MM-DD-HHMM-$ARGUMENTS.md` (or just `YYYY-MM-DD-HHMM.md` if no name provided). If the local `./claude` or `.claude/sessions/` directories do not exist, I will create them first.

The session file should begin with:

1. Session name and timestamp as the title
2. Session overview section with start time and context
3. Current git state and branch
4. Goals and objectives section (ask user if not clear)
5. Empty progress section ready for updates to be tracked throughout the session

After creating the file, I will create or update `.claude/sessions/.current-session` to track the active session filename.

Please tell me:

1. What are we working on today?
2. What specific goals do you want to accomplish?
3. Any context I should know about?

I'll add this session context to the newly created session file, as detailed above, ensuring our progress is tracked and can be resumed later. Keep in mind this is slighly different from Claude Code CLI's native memory management that uses the local and/or global CLAUDE.md files. We use this other approach to keep the CLAUDE.md files lean.

**Important**: I will NEVER:

- Add "Co-authored-by" or any Claude signatures
- Include "Generated with Claude Code" or similar messages
- Modify git config or user credentials
- Add any AI/assistant attribution to the commit

The session context will be preserved in the appropriate session file for reference and continuation until the session is ended.

Finally I will confirm the session has started and remind the user they can:

- Update it with `/project:session-update`
- End it with `/project:session-end`