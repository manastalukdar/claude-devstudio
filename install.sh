#!/bin/bash
# Claude DevStudio Installer for Mac/Linux

set -e

SKILLS_DIR="$HOME/.claude/skills"
MANIFEST_FILE="$SKILLS_DIR/.claude-devstudio-manifest"
REPO_URL="https://raw.githubusercontent.com/manastalukdar/claude-devstudio/main/skills"
API_URL="https://api.github.com/repos/manastalukdar/claude-devstudio/contents/skills"

mkdir -p "$SKILLS_DIR"

# Dynamically discover all skills from GitHub API
echo "Fetching skill list from repository..."
API_RESPONSE=$(curl -sSL "$API_URL" -H "Accept: application/vnd.github.v3+json")

# Parse skill names (requires jq; falls back to grep+sed)
if command -v jq &> /dev/null; then
    mapfile -t SKILLS < <(echo "$API_RESPONSE" | jq -r '.[].name' 2>/dev/null)
else
    mapfile -t SKILLS < <(echo "$API_RESPONSE" | grep '"name"' | sed 's/.*"name": "\(.*\)".*/\1/' | grep -v '^\[' | sort -u)
fi

if [ "${#SKILLS[@]}" -eq 0 ]; then
    echo "[ERROR] Failed to fetch skill list from GitHub. Check your network connection."
    echo "Tip: Try the Python installer instead: python3 install.py"
    exit 1
fi

echo "Found ${#SKILLS[@]} skills."

# Check for existing skills
EXISTING=0
for skill in "${SKILLS[@]}"; do
    if [ -d "$SKILLS_DIR/$skill" ]; then
        ((EXISTING++)) || true
    fi
done

if [ "$EXISTING" -gt 0 ]; then
    echo "[WARNING] Found $EXISTING existing skills in $SKILLS_DIR"
    read -p "Overwrite existing skills? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "[CANCELLED] Installation cancelled."
        echo "Tip: Use uninstall script first to remove old skills."
        exit 0
    fi
fi

echo "Downloading skills..."
INSTALLED=0
FAILED=0
for skill in "${SKILLS[@]}"; do
    mkdir -p "$SKILLS_DIR/$skill"
    if curl -sSL "$REPO_URL/$skill/SKILL.md" -o "$SKILLS_DIR/$skill/SKILL.md" 2>/dev/null; then
        echo "  + $skill"
        ((INSTALLED++)) || true
    else
        echo "  ! Failed: $skill"
        ((FAILED++)) || true
    fi
done

# Write manifest for uninstaller
printf '%s\n' "${SKILLS[@]}" > "$MANIFEST_FILE"

echo ""
echo "[SUCCESS] Installed $INSTALLED skills to $SKILLS_DIR"
[ "$FAILED" -gt 0 ] && echo "[WARNING] $FAILED skills failed to download"
echo "Type / in Claude Code to see available skills"