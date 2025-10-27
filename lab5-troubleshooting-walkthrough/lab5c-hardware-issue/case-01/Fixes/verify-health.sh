#!/usr/bin/env bash
echo "Checking SMART status..."
diskutil info disk0 | grep SMART
echo "Verifying I/O performance..."
iostat -w 2 -c 3
