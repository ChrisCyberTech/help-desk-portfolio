#!/usr/bin/env bash
# collect-evidence.sh — Hardware diagnostics (disk, memory, peripherals)
set -euo pipefail
OUTDIR="$(cd "$(dirname "$0")" && pwd)"
TS=$(date +"%Y-%m-%d_%H-%M-%S")
echo "Collecting hardware diagnostics @ $TS"

# 1. Basic system info
{ uname -a; system_profiler SPHardwareDataType; } > "$OUTDIR/systeminfo.txt" 2>&1

# 2. Disk status
{ diskutil list; diskutil info /; diskutil verifyVolume /; } > "$OUTDIR/disk.txt" 2>&1

# 3. SMART status
{ diskutil info disk0 | grep -i SMART; } > "$OUTDIR/smart.txt" 2>&1

# 4. I/O performance snapshot
{ echo "IOSTAT sample:"; iostat -w 2 -c 3; } > "$OUTDIR/io.txt" 2>&1

# 5. Memory pressure
{ vm_stat; } > "$OUTDIR/memory.txt" 2>&1

# 6. Connected peripherals
{ system_profiler SPUSBDataType SPThunderboltDataType SPNetworkDataType; } > "$OUTDIR/peripherals.txt" 2>&1

echo "All evidence saved in: $OUTDIR"
