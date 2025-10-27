#!/usr/bin/env bash
set -euo pipefail
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder || true
echo "DNS cache flushed."
