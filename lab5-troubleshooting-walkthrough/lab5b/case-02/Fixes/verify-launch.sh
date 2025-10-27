#!/usr/bin/env bash
# Usage: ./verify-launch.sh "/Applications/AppName.app"
set -euo pipefail

APP_PATH="${1:-}"
if [[ -z "$APP_PATH" || ! -d "$APP_PATH" ]]; then
  echo "Usage: $0 \"/Applications/AppName.app\"" >&2; exit 1
fi

APP_BASENAME="$(basename "$APP_PATH")"

echo "Launching: $APP_BASENAME"
open "$APP_PATH"
sleep 6

echo "Checking process list…"
pgrep -fl "${APP_BASENAME%.app}" || echo "Process not found."

echo "Recent logs mentioning ${APP_BASENAME%.app} (last 2m):"
log show --style syslog --last 2m --predicate "process CONTAINS[c] \"${APP_BASENAME%.app}\"" 2>/dev/null | tail -n 50 || true

echo "Done."
