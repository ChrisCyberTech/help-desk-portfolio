#!/usr/bin/env bash
set -euo pipefail

echo "[1/3] Closing Chrome…"
pkill -f "Google Chrome" || true
sleep 1

echo "[2/3] Clearing Chrome caches…"
rm -rf "$HOME/Library/Caches/Google/Chrome/"* 2>/dev/null || true
rm -rf "$HOME/Library/Application Support/Google/Chrome/ShaderCache/"* 2>/dev/null || true
rm -rf "$HOME/Library/Application Support/Google/Chrome/GrShaderCache/"* 2>/dev/null || true

echo "[3/3] Launching Chrome without extensions/GPU…"
open -a "Google Chrome" --args --disable-extensions --disable-gpu --new-window "https://www.google.com"

echo "Tip: If this run feels fast/smooth, the issue was likely extensions or cache."
