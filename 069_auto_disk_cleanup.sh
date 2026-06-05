#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to automatically
clean disk space when usage exceeds
a threshold.

What this script does:
1. Checks disk usage
2. Deletes old log files
3. Deletes old backups
4. Compresses large logs
5. Generates cleanup report
=========================================================
COMMENT

threshold=80

log_dir="/var/log"
backup_dir="/home/dopadm/backups"

usage=$(df -h / | awk 'NR==2 {print $5}' | cut -d'%' -f1)

echo "================================="
echo " AUTOMATIC DISK CLEANUP REPORT"
echo "================================="

echo "Current Disk Usage : ${usage}%"

if [ "$usage" -gt "$threshold" ]
then
    echo ""
    echo "WARNING: Disk usage exceeded ${threshold}%"
    echo "Starting cleanup..."

    # Delete logs older than 30 days
    find "$log_dir" -type f -name "*.log" -mtime +30 -delete

    # Delete backups older than 90 days
    find "$backup_dir" -type f -mtime +90 -delete

    # Compress large logs (>100MB)
    find "$log_dir" -type f -name "*.log" -size +100M \
    -exec gzip {} \;

    echo ""
    echo "Cleanup completed."

else
    echo "Disk usage is normal."
fi