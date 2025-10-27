#!/usr/bin/env bash
set -euo pipefail

echo "Waiting 10s to let Chrome settle…"
sleep 10

OUT="verification-$(date +%Y%m%d-%H%M%S).txt"
{
  echo "=== Chrome Metrics @ $(date) ==="
  ps -axo pid,comm,%cpu,rss | grep -i "Google Chrome" | grep -v grep
  echo
  TOTAL_RSS=$(ps -axo rss,comm | grep -i "Google Chrome" | grep -v grep | awk '{sum+=$1} END {print sum}')
  echo "Total Chrome RSS (KB): ${TOTAL_RSS:-0}"
} | tee "$OUT"

echo "Saved: $OUT"
