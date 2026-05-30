#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to take backup and
maintain only the latest 5 backups.

What this script does:
1. Creates compressed backup
2. Stores backup in backup directory
3. Adds timestamp to backup name
4. Keeps only latest 5 backups
5. Deletes older backups automatically
=========================================================
COMMENT

# Source directory
source_dir="/home/dopadm/uploads"

# Backup directory
backup_dir="/home/dopadm/backups"

# Create backup directory if not exists
mkdir -p "$backup_dir"

# Timestamp
timestamp=$(date +"%Y%m%d_%H%M%S")

# Backup file name
backup_file="backup_${timestamp}.tar.gz"

# Create backup
tar -czf "$backup_dir/$backup_file" "$source_dir"

# Check backup status
if [ $? -eq 0 ]
then
    echo "Backup created successfully:"
    echo "$backup_dir/$backup_file"
else
    echo "Backup failed"
    exit 1
fi

# Keep only latest 5 backups
ls -1t "$backup_dir"/backup_*.tar.gz | tail -n +6 | xargs -r rm -f

echo "Retention policy applied."
echo "Only latest 5 backups retained."