#!/usr/bin/env bash
# Team Skills Master - one-line bootstrap installer (macOS / Linux)
# Ensures git, clones/updates the repo, then runs the full installer (skills + Python).
set -uo pipefail
REPO="https://github.com/rohitchugh/team-skills-master.git"
DIR="$HOME/team-skills-master"

echo ""
echo "Team Skills Master - installer"
echo "=============================="

# 1. Ensure git.
if ! command -v git >/dev/null 2>&1; then
  echo "Installing git..."
  if [ "$(uname)" = "Darwin" ]; then
    if command -v brew >/dev/null 2>&1; then brew install git; else xcode-select --install || true; fi
  else
    if   command -v apt-get >/dev/null 2>&1; then sudo apt-get update -y && sudo apt-get install -y git
    elif command -v dnf     >/dev/null 2>&1; then sudo dnf install -y git
    elif command -v pacman  >/dev/null 2>&1; then sudo pacman -Sy --noconfirm git
    fi
  fi
fi
command -v git >/dev/null 2>&1 || { echo "ERROR: git not available. Install git then re-run."; exit 1; }

# 2. Download. Uses the read-only token from $TSM_TOKEN (set in the install
#    command). Falls back to normal GitHub auth if no token is provided.
BASE="github.com/rohitchugh/team-skills-master.git"
if [ -n "${TSM_TOKEN:-}" ]; then CLONE_URL="https://oauth2:${TSM_TOKEN}@${BASE}"; else CLONE_URL="https://${BASE}"; fi

rm -rf "$DIR"   # always fetch a clean, latest copy
echo "Downloading the latest skills to $DIR ..."
git clone --depth 1 "$CLONE_URL" "$DIR"
[ -d "$DIR/.git" ] && git -C "$DIR" remote set-url origin "https://${BASE}"   # strip token from config
[ -f "$DIR/install.sh" ] || { echo "ERROR: download failed. Make sure you have access to the private repo."; exit 1; }

# 3. Run the installer (copies skills + sets up Python + packages).
bash "$DIR/install.sh"
