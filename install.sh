#!/usr/bin/env bash
# macOS / Linux installer. Run: bash install.sh
# Installs the skills, then ensures Python + the packages the xlsx skill needs.
set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$ROOT/skills"
DEST="$HOME/.claude/skills"

# ---------------------------------------------------------------------------
# 1. Install the skills
# ---------------------------------------------------------------------------
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

# ---------------------------------------------------------------------------
# 2. Ensure Python (needed by the xlsx skill scripts)
# ---------------------------------------------------------------------------
echo ""
echo "Checking Python (needed by the xlsx skill)..."

PY=""
for c in python3 python; do
  if command -v "$c" >/dev/null 2>&1 && "$c" -c 'import sys; sys.exit(0 if sys.version_info[0]==3 else 1)' >/dev/null 2>&1; then
    PY="$c"; break
  fi
done

if [ -z "$PY" ]; then
  echo "  Python 3 not found. Attempting to install..."
  if [ "$(uname)" = "Darwin" ]; then
    if command -v brew >/dev/null 2>&1; then brew install python || true; fi
  else
    if   command -v apt-get >/dev/null 2>&1; then sudo apt-get update -y && sudo apt-get install -y python3 python3-pip || true
    elif command -v dnf     >/dev/null 2>&1; then sudo dnf install -y python3 python3-pip || true
    elif command -v pacman  >/dev/null 2>&1; then sudo pacman -Sy --noconfirm python python-pip || true
    fi
  fi
  for c in python3 python; do
    if command -v "$c" >/dev/null 2>&1; then PY="$c"; break; fi
  done
fi

if [ -z "$PY" ]; then
  echo "  Could not auto-install Python. Install Python 3 manually, then re-run."
  echo "  (Only the xlsx automation needs Python.)"
else
  echo "  Python ready: $($PY --version 2>&1)"
  echo "  Installing required packages (openpyxl, pandas, lxml, defusedxml)..."
  "$PY" -m pip install --upgrade pip --quiet || true
  if [ -f "$ROOT/requirements.txt" ]; then
    "$PY" -m pip install -r "$ROOT/requirements.txt" --quiet || "$PY" -m pip install --user -r "$ROOT/requirements.txt" --quiet || true
  else
    "$PY" -m pip install openpyxl pandas lxml defusedxml --quiet || "$PY" -m pip install --user openpyxl pandas lxml defusedxml --quiet || true
  fi
  echo "  Python packages installed."
fi

echo ""
echo "------------------------------------------------------------"
echo " DONE. Next steps:"
echo "   1. Close and reopen Claude Code (skills load at startup)"
echo "   2. Type:  /team-inboxing-mastery   (your starting point)"
echo "   3. Read skills/team-inboxing-mastery/PLAYBOOK.pdf first"
echo ""
echo " Note: xlsx formula recalculation (scripts/recalc.py) also needs"
echo " LibreOffice. Optional - install from libreoffice.org if needed."
echo "------------------------------------------------------------"
