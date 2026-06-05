#!/bin/bash

backup_dir="/home/dopadm/backups"

latest_backup=$(ls -t "$backup_dir"/*.tar.gz 2>/dev/null | head -1)

if [ -z "$latest_backup" ]
then
    echo "No backup found"
    exit 1
fi

echo "Latest Backup : $latest_backup"

echo "Size : $(du -sh "$latest_backup" | awk '{print $1}')"

echo "Date : $(date -r "$latest_backup")"