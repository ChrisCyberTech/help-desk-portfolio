#!/usr/bin/env bash
# Disable system web/secure proxy & clear env vars (macOS)
set -euo pipefail
SVC="${1:-Wi-Fi}"
echo "Disabling proxies on service: $SVC"
networksetup -setwebproxystate "$SVC" off 2>/dev/null || true
networksetup -setsecurewebproxystate "$SVC" off 2>/dev/null || true
unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY all_proxy ALL_PROXY || true
echo "Proxies disabled."
