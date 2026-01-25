#!/bin/bash
# Claude DevStudio Uninstaller for Mac/Linux

set -e

echo "Claude DevStudio Uninstaller"
echo "============================"

SKILLS_DIR="$HOME/.claude/skills"
COMMANDS_DIR="$HOME/.claude/commands"

# List of Claude DevStudio skills
SKILLS=(
    "cleanproject"
    "commit"
    "contributing"
    "create-todos"
    "docs"
    "explain-like-senior"
    "find-todos"
    "fix-imports"
    "fix-todos"
    "format"
    "implement"
    "make-it-pretty"
    "predict-issues"
    "refactor"
    "remove-comments"
    "review"
    "scaffold"
    "security-scan"
    "session-current"
    "session-end"
    "session-help"
    "session-list"
    "session-resume"
    "session-start"
    "session-update"
    "sessions-init"
    "test"
    "todos-to-issues"
    "understand"
    "undo"
)

# Legacy command files
LEGACY_COMMANDS=(
    "cleanproject.md"
    "cleanup-types.md"  # Old command (removed)
    "commit.md"
    "context-cache.md"  # Old command (removed)
    "contributing.md"
    "create-todos.md"
    "docs.md"
    "explain-like-senior.md"
    "find-todos.md"
    "fix-imports.md"
    "fix-todos.md"
    "format.md"
    "implement.md"
    "make-it-pretty.md"
    "predict-issues.md"
    "refactor.md"
    "remove-comments.md"
    "review.md"
    "scaffold.md"
    "security-scan.md"
    "session-current.md"
    "session-end.md"
    "session-help.md"
    "session-list.md"
    "session-resume.md"
    "session-start.md"
    "session-update.md"
    "sessions-init.md"
    "test.md"
    "todos-to-issues.md"
    "understand.md"
    "undo.md"
)

# Count installed skills
INSTALLED_SKILLS=0
if [ -d "$SKILLS_DIR" ]; then
    for skill in "${SKILLS[@]}"; do
        if [ -d "$SKILLS_DIR/$skill" ]; then
            ((INSTALLED_SKILLS++))
        fi
    done
fi

# Count installed legacy commands
INSTALLED_LEGACY=0
if [ -d "$COMMANDS_DIR" ]; then
    for cmd in "${LEGACY_COMMANDS[@]}"; do
        if [ -f "$COMMANDS_DIR/$cmd" ]; then
            ((INSTALLED_LEGACY++))
        fi
    done
fi

if [ $INSTALLED_SKILLS -eq 0 ] && [ $INSTALLED_LEGACY -eq 0 ]; then
    echo "[INFO] No Claude DevStudio skills or commands found."
    exit 0
fi

# Show what will be removed
if [ $INSTALLED_SKILLS -gt 0 ]; then
    echo "[FOUND] $INSTALLED_SKILLS Claude DevStudio skills (new format)"
fi
if [ $INSTALLED_LEGACY -gt 0 ]; then
    echo "[FOUND] $INSTALLED_LEGACY legacy command files (old format)"
fi

read -p "Remove all Claude DevStudio skills and commands? (y/N): " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "[CANCELLED] Uninstall cancelled."
    exit 0
fi

# Remove skills (new format)
REMOVED_SKILLS=0
if [ -d "$SKILLS_DIR" ]; then
    for skill in "${SKILLS[@]}"; do
        if [ -d "$SKILLS_DIR/$skill" ]; then
            rm -rf "$SKILLS_DIR/$skill"
            echo "  - Removed skill: $skill"
            ((REMOVED_SKILLS++))
        fi
    done
fi

# Remove legacy commands (old format)
REMOVED_LEGACY=0
if [ -d "$COMMANDS_DIR" ]; then
    for cmd in "${LEGACY_COMMANDS[@]}"; do
        if [ -f "$COMMANDS_DIR/$cmd" ]; then
            rm "$COMMANDS_DIR/$cmd"
            echo "  - Removed legacy command: $cmd"
            ((REMOVED_LEGACY++))
        fi
    done
fi

# Clean up cache and backups
CACHE_DIR="$HOME/.claude/.ccplugins_cache"
BACKUP_DIR="$HOME/.claude/.ccplugins_backups"

if [ -d "$CACHE_DIR" ] || [ -d "$BACKUP_DIR" ]; then
    read -p "Also remove cache and backups? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        [ -d "$CACHE_DIR" ] && rm -rf "$CACHE_DIR" && echo "  - Removed cache directory"
        [ -d "$BACKUP_DIR" ] && rm -rf "$BACKUP_DIR" && echo "  - Removed backups directory"
    fi
fi

TOTAL_REMOVED=$((REMOVED_SKILLS + REMOVED_LEGACY))
echo "[SUCCESS] Uninstalled $REMOVED_SKILLS skills and $REMOVED_LEGACY legacy commands ($TOTAL_REMOVED total)"
echo "Thanks for trying Claude DevStudio!"