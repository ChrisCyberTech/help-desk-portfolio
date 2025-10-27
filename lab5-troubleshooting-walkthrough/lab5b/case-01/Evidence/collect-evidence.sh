#!/usr/bin/env bash
# collect-evidence.sh – Chrome slowness evidence collection (macOS/Linux)
set -e
OUTDIR="$(cd "$(dirname "$0")" && pwd)"
TS=$(date +"%Y-%m-%d_%H-%M-%S")
LOGFILE="$OUTDIR/_run-$TS.txt"

echo "Collecting Chrome slowness evidence @ $TS" | tee "$LOGFILE"

# ---- System ----
{
  echo "### System Info"
  uname -a
  sw_vers 2>/dev/null || lsb_release -a 2>/dev/null
} > "$OUTDIR/systeminfo.txt" 2>&1

# ---- Processes ----
{
  echo "### Top CPU Processes"
  ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 20
  echo
  echo "### Top Memory Processes"
  ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 20
  echo
  echo "### Chrome Processes"
  pgrep -a chrome || echo "No Chrome processes running"
} > "$OUTDIR/processes.txt" 2>&1

# ---- Disk ----
{
  echo "### Disk Usage"
  df -h
  echo
  echo "### Disk I/O (if iostat available)"
  iostat -xz 1 3 2>/dev/null || echo "iostat not installed"
} > "$OUTDIR/disk.txt" 2>&1

# ---- Network ----
{
  echo "### DNS & Connectivity"
  nslookup google.com 2>&1 || dig google.com 2>&1
  echo
  echo "### Ping Test"
  ping -c 4 google.com || echo "Ping failed"
} > "$OUTDIR/network.txt" 2>&1

# ---- System Logs ----
{
  echo "### Chrome-related Logs (past 2h)"
  log show --predicate 'process contains "chrome"' --last 2h 2>/dev/null | tail -n 100
} > "$OUTDIR/logs.txt" 2>&1

echo "Evidence collection complete @ $(date)" | tee -a "$LOGFILE"
