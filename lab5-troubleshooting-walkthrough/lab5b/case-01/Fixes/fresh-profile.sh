#!/usr/bin/env bash
set -euo pipefail

PROFILE_ROOT="$HOME/Library/Application Support/Google/Chrome"
DEFAULT_DIR="$PROFILE_ROOT/Default"
TS=$(date +"%Y%m%d-%H%M%S")

echo "Closing Chrome…"
pkill -f "Google Chrome" || true
sleep 1

if [ -d "$DEFAULT_DIR" ]; then
  echo "Backing up existing profile to Default_old-$TS …"
  mv "$DEFAULT_DIR" "$PROFILE_ROOT/Default_old-$TS"
else
  echo "No existing Default profile found; continuing."
fi

echo "Launching Chrome (fresh profile will be created)…"
open -a "Google Chrome" --args --new-window "chrome://version"

echo "Note: You can later copy back Bookmarks from the backup:
$PROFILE_ROOT/Default_old-$TS/Bookmarks"
