#!/usr/bin/env python3
# Claude DevStudio Installer

"""
Claude DevStudio Installer
Copies skill files to ~/.claude/skills/
"""

import os
import shutil
import sys
from pathlib import Path

def main():
    # Determine paths
    script_dir = Path(__file__).parent.absolute()
    skills_source = script_dir / "skills"
    claude_dir = Path.home() / ".claude"
    skills_dest = claude_dir / "skills"

    print("Claude DevStudio Installer")
    print("=" * 40)

    # Check source directory exists
    if not skills_source.exists():
        print(f"[ERROR] Skills directory not found at {skills_source}")
        sys.exit(1)

    # Get all skill directories
    skill_dirs = [d for d in skills_source.iterdir() if d.is_dir()]
    if not skill_dirs:
        print(f"[ERROR] No skill directories found in {skills_source}")
        sys.exit(1)

    # Create destination directory
    skills_dest.mkdir(parents=True, exist_ok=True)
    print(f"[OK] Target directory: {skills_dest}")

    # Check for existing skills
    existing_skills = []
    for skill_dir in skill_dirs:
        dest_skill_dir = skills_dest / skill_dir.name
        if dest_skill_dir.exists():
            existing_skills.append(skill_dir.name)

    if existing_skills:
        print(f"\n[WARNING] Found {len(existing_skills)} existing skills:")
        for skill in existing_skills[:10]:  # Show first 10
            print(f"  ! {skill}")
        if len(existing_skills) > 10:
            print(f"  ... and {len(existing_skills) - 10} more")

        response = input("\nOverwrite existing skills? (y/N): ")
        if response.lower() != 'y':
            print("[CANCELLED] Installation cancelled.")
            print("Tip: Use uninstall script first to remove old skills.")
            sys.exit(0)

    print(f"\n[INSTALL] Installing {len(skill_dirs)} skills:")
    installed_count = 0
    for skill_dir in skill_dirs:
        skill_file = skill_dir / "SKILL.md"
        if not skill_file.exists():
            print(f"  ⚠ Skipping {skill_dir.name} (no SKILL.md)")
            continue

        dest_skill_dir = skills_dest / skill_dir.name
        dest_skill_dir.mkdir(parents=True, exist_ok=True)

        # Copy SKILL.md and any other files in the skill directory
        for file in skill_dir.iterdir():
            if file.is_file():
                dest_file = dest_skill_dir / file.name
                shutil.copy2(file, dest_file)

        print(f"  + {skill_dir.name}")
        installed_count += 1

    print(f"\n[SUCCESS] Installation complete! Installed {installed_count} skills.")
    print("\nUsage:")
    print("  1. Open Claude Code CLI")
    print("  2. Type / to see available skills")
    print("  3. Use /tdd-red-green, /ci-setup, /api-test-generate, etc.")
    print("\nTip: With 46+ professional skills, Claude DevStudio will save you 8-10 hours per week!")

if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(f"\n[ERROR] Installation failed: {e}")
        sys.exit(1)