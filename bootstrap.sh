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

# 2. Download the latest skills (public repo, no login needed).
URL="https://github.com/rohitchugh/team-skills-master.git"
rm -rf "$DIR"   # always fetch a clean, latest copy
echo "Downloading the latest skills to $DIR ..."
git clone --depth 1 "$URL" "$DIR"
[ -f "$DIR/install.sh" ] || { echo "ERROR: download failed. Make sure you have access to the private repo."; exit 1; }

# 3. Run the installer (copies skills + sets up Python + packages).
bash "$DIR/install.sh"
