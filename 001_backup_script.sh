#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to take backup of a directory,
compress it into a .tar.gz file, and store it
inside a backup folder with timestamp.

What this script does:
1. Takes backup of the source directory
2. Creates compressed .tar.gz archive
3. Stores backup inside backup directory
4. Adds timestamp to backup filename
5. Checks whether backup succeeded or failed
=========================================================
COMMENT

# Source directory to backup
source_dir="yugabytedb-cloud-automation-gcp"

# Backup destination directory
backup_dir="/home/dopadm/backups"

# Generate timestamp
timestamp=$(date +"%Y%m%d_%H%M%S")

# Backup file name
backup_file="yugabytedb-cloud-automation-gcp_${timestamp}.tar.gz"

# Create backup directory if not exists
mkdir -p "$backup_dir"

# Create compressed backup archive
tar -czf "$backup_dir/$backup_file" "$source_dir"

# Check backup status
if [ $? -eq 0 ]
then
    echo "Backup completed successfully"
    echo "Backup stored at:"
    echo "$backup_dir/$backup_file"
else
    echo "Backup failed"
fi