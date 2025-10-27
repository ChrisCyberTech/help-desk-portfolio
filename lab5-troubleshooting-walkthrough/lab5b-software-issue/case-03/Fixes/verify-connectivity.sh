#!/usr/bin/env bash
# Quick HTTP/TLS check to a target
set -euo pipefail
TARGET="${1:-https://example.com}"
echo "curl check:"; curl -s -o /dev/null -w "HTTP %{http_code}\n" --max-time 10 "$TARGET" || true
HOST="$(echo "$TARGET" | sed -E 's#https?://([^/:]+).*#\1#')"
echo "TLS handshake:"; echo | openssl s_client -connect "${HOST}:443" -servername "$HOST" -brief 2>/dev/null | head -n 3
echo "Done."
