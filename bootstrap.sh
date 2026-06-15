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

# 2. Clone or update (you may be prompted to sign in to GitHub the first time).
if [ -d "$DIR/.git" ]; then
  echo "Updating existing copy at $DIR ..."
  git -C "$DIR" pull --ff-only
else
  echo "Downloading the repo to $DIR (sign in to GitHub if prompted)..."
  git clone "$REPO" "$DIR"
fi
[ -f "$DIR/install.sh" ] || { echo "ERROR: download failed. Make sure you have access to the private repo."; exit 1; }

# 3. Run the installer (copies skills + sets up Python + packages).
bash "$DIR/install.sh"
