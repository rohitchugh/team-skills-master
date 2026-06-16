#!/usr/bin/env python3
"""
Configure a team member's Claude Code to work like the owner's setup:
  1. Turn on bypassPermissions (skills run without permission prompts).
  2. Install the team operating rules to ~/.claude/CLAUDE.md (only if absent).

Safe + idempotent: merges into existing settings.json without touching other keys
(hooks, env, mcpServers, etc.). Run by install.bat / install.sh.
"""
import json
import shutil
from pathlib import Path

CLAUDE_DIR = Path.home() / ".claude"
SETTINGS = CLAUDE_DIR / "settings.json"
CLAUDE_MD = CLAUDE_DIR / "CLAUDE.md"
RULES_SRC = Path(__file__).with_name("team-operating-rules.md")


def merge_settings():
    CLAUDE_DIR.mkdir(parents=True, exist_ok=True)
    data = {}
    if SETTINGS.exists() and SETTINGS.read_text(encoding="utf-8").strip():
        try:
            data = json.loads(SETTINGS.read_text(encoding="utf-8"))
        except json.JSONDecodeError:
            backup = SETTINGS.with_suffix(".json.bak")
            shutil.copy2(SETTINGS, backup)
            print(f"  ! settings.json was invalid JSON; backed up to {backup.name}, writing fresh")
            data = {}
    perms = data.get("permissions")
    if not isinstance(perms, dict):
        perms = {}
    perms["defaultMode"] = "bypassPermissions"
    data["permissions"] = perms
    SETTINGS.write_text(json.dumps(data, indent=2) + "\n", encoding="utf-8")
    print("  set permissions.defaultMode = bypassPermissions (skills run without prompts)")


def install_rules():
    if not RULES_SRC.exists():
        return
    if CLAUDE_MD.exists() and CLAUDE_MD.read_text(encoding="utf-8").strip():
        print(f"  CLAUDE.md already exists - left as-is. Team rules are in {RULES_SRC.name} if you want to merge them.")
    else:
        shutil.copy2(RULES_SRC, CLAUDE_MD)
        print("  installed team operating rules to ~/.claude/CLAUDE.md")


if __name__ == "__main__":
    print("Configuring Claude Code settings...")
    merge_settings()
    install_rules()
    print("Settings configured.")
