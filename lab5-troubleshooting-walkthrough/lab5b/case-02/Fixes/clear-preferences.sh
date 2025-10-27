#!/usr/bin/env bash
# Usage (preferred): ./clear-preferences.sh "/Applications/AppName.app"
# Or (if you already know it): ./clear-preferences.sh com.vendor.AppName
set -euo pipefail

APP_OR_BUNDLE="${1:-}"
if [[ -z "$APP_OR_BUNDLE" ]]; then
  echo "Usage: $0 \"/Applications/AppName.app\"  OR  $0 com.vendor.AppName" >&2; exit 1
fi

BUNDLE_ID=""
APP_NAME=""
if [[ -d "$APP_OR_BUNDLE" ]]; then
  INFO="$APP_OR_BUNDLE/Contents/Info.plist"
  BUNDLE_ID=$(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "$INFO" 2>/dev/null || true)
  APP_NAME=$(/usr/libexec/PlistBuddy -c 'Print :CFBundleName' "$INFO" 2>/dev/null || basename "$APP_OR_BUNDLE" .app)
else
  BUNDLE_ID="$APP_OR_BUNDLE"
  APP_NAME="$APP_OR_BUNDLE"
fi

if [[ -z "$BUNDLE_ID" ]]; then
  echo "Could not determine CFBundleIdentifier." >&2; exit 2
fi

echo "Clearing preferences/caches for: $BUNDLE_ID"
defaults delete "$BUNDLE_ID" 2>/dev/null || true
rm -f "$HOME/Library/Preferences/${BUNDLE_ID}.plist" 2>/dev/null || true
rm -rf "$HOME/Library/Caches/${BUNDLE_ID}" 2>/dev/null || true

# Try common “Application Support” path using app name
AS_DIR="$HOME/Library/Application Support/${APP_NAME}"
if [[ -d "$AS_DIR" ]]; then
  echo "Backing up Application Support → ${AS_DIR}.bak"
  mv "$AS_DIR" "${AS_DIR}.bak-$(date +%Y%m%d-%H%M%S)"
fi

echo "Done."
