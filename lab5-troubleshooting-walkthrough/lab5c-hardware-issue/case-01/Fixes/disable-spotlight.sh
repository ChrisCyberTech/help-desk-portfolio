#!/usr/bin/env bash
echo "Disabling Spotlight indexing on backup drives..."
sudo mdutil -i off /Volumes/BackupDrive
sudo mdutil -E /Volumes/BackupDrive
echo "Spotlight indexing disabled."
