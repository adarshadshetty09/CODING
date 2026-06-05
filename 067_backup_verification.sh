#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to verify backup
integrity and freshness.

What this script does:
1. Checks backup file exists
2. Checks backup file size
3. Checks backup creation date
4. Generates verification report
=========================================================
COMMENT

backup_file="/home/dopadm/backups/project_backup.tar.gz"

echo "================================="
echo " BACKUP VERIFICATION REPORT"
echo "================================="

# Check File Exists
if [ -f "$backup_file" ]
then
    echo "✅ Backup file exists"
else
    echo "❌ Backup file missing"
    exit 1
fi

# Check File Size
size=$(stat -c%s "$backup_file")

if [ "$size" -gt 0 ]
then
    echo "✅ Backup file size is valid"
else
    echo "❌ Backup file is empty"
fi

# Check Backup Date
backup_date=$(date -r "$backup_file" +%Y-%m-%d)
today=$(date +%Y-%m-%d)

if [ "$backup_date" = "$today" ]
then
    echo "✅ Backup created today"
else
    echo "❌ Backup is outdated"
fi