#!/usr/bin/env bash
# Usage: ./reset-permissions.sh "/Applications/Google Chrome.app"
set -euo pipefail

APP_PATH="${1:-}"
if [[ -z "$APP_PATH" ]]; then
  echo "Usage: $0 \"/Applications/AppName.app\"" >&2; exit 1
fi
if [[ ! -d "$APP_PATH" ]]; then
  echo "Error: App not found at: $APP_PATH" >&2; exit 2
fi

echo "Removing quarantine attribute…"
sudo xattr -dr com.apple.quarantine "$APP_PATH" || true

echo "Fixing ownership to current user…"
sudo chown -R "$(whoami)":staff "$APP_PATH"

echo "Ensuring readable/executable bits…"
sudo chmod -R a+rX "$APP_PATH"

echo "Verifying code signature (informational)…"
codesign --verify --deep --strict --verbose=2 "$APP_PATH" 2>&1 | tee codesign-verify.txt || true

echo "Done."
