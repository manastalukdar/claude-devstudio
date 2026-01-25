#!/bin/bash
# Claude DevStudio Installer for Mac/Linux

set -e
SKILLS_DIR="$HOME/.claude/skills"
mkdir -p "$SKILLS_DIR"

# Download skills from GitHub
REPO_URL="https://raw.githubusercontent.com/manastalukdar/claude-devstudio/running/skills"
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

# Check for existing skills
EXISTING=0
for skill in "${SKILLS[@]}"; do
    if [ -d "$SKILLS_DIR/$skill" ]; then
        ((EXISTING++))
    fi
done

if [ $EXISTING -gt 0 ]; then
    echo "[WARNING] Found $EXISTING existing skills"
    read -p "Overwrite existing skills? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "[CANCELLED] Installation cancelled."
        echo "Tip: Use uninstall script first to remove old skills."
        exit 0
    fi
fi

echo "Downloading skills..."
for skill in "${SKILLS[@]}"; do
    mkdir -p "$SKILLS_DIR/$skill"
    curl -sSL "$REPO_URL/$skill/SKILL.md" -o "$SKILLS_DIR/$skill/SKILL.md"
    echo "  + $skill"
done
echo ""
echo "[SUCCESS] Claude DevStudio installed to $SKILLS_DIR"
echo "Type / in Claude Code to see available skills"