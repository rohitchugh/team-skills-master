#!/usr/bin/env bash
# macOS / Linux installer. Run: bash install.sh
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$ROOT/skills"
DEST="$HOME/.claude/skills"

[ -d "$SRC" ] || { echo "ERROR: skills folder not found next to this script."; exit 1; }
mkdir -p "$DEST"

echo "Installing Team Skills Master into:"
echo "  $DEST"
echo ""
for d in "$SRC"/*/; do
  name="$(basename "$d")"
  rm -rf "$DEST/$name"
  cp -r "$d" "$DEST/$name"
  echo "  installed: $name"
done

echo ""
echo "------------------------------------------------------------"
echo " DONE. Next steps:"
echo "   1. Close and reopen Claude Code (skills load at startup)"
echo "   2. Type:  /team-inboxing-mastery   (your starting point)"
echo "   3. Read skills/team-inboxing-mastery/PLAYBOOK.pdf first"
echo "------------------------------------------------------------"
