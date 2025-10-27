#!/usr/bin/env bash
# collect-evidence.sh – Case 02: App Won’t Launch (Instant Crash)
set -e
OUTDIR="$(cd "$(dirname "$0")" && pwd)"
TS=$(date +"%Y-%m-%d_%H-%M-%S")
LOGFILE="$OUTDIR/_run-$TS.txt"

echo "Collecting evidence for launch failure @ $TS" | tee "$LOGFILE"

# ---- System info ----
{
  echo "### System Info"
  uname -a
  sw_vers 2>/dev/null || lsb_release -a 2>/dev/null
  echo
  echo "### Disk Usage"
  df -h
} > "$OUTDIR/systeminfo.txt" 2>&1

# ---- Recent app crash / launch logs ----
{
  echo "### DiagnosticReports (last 3)"
  ls -lt ~/Library/Logs/DiagnosticReports | head -n 3
  echo
  echo "### Log entries mentioning 'crash' or 'launchservices'"
  log show --predicate 'eventMessage CONTAINS[c] "crash" OR eventMessage CONTAINS[c] "launchservices"' --last 2h 2>/dev/null | tail -n 100
} > "$OUTDIR/logs.txt" 2>&1

# ---- Process check ----
{
  echo "### Process Snapshot"
  ps -eo pid,comm,%cpu,%mem | head -n 15
} > "$OUTDIR/processes.txt" 2>&1

# ---- Permissions on Applications ----
{
  echo "### Applications folder permissions"
  ls -ld /Applications
  echo
  echo "### App bundle permissions (replace Example.app if known)"
  ls -l "/Applications/Example.app" 2>/dev/null || echo "App placeholder not present."
} > "$OUTDIR/permissions.txt" 2>&1

echo "Evidence collection complete @ $(date)" | tee -a "$LOGFILE"
