#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script for log rotation
and cleanup.

What this script does:
1. Finds .log files
2. Compresses logs older than 7 days
3. Deletes logs older than 30 days
4. Helps manage disk space
=========================================================
COMMENT

log_dir="/var/log"

echo "================================="
echo " LOG ROTATION REPORT"
echo "================================="

echo ""
echo "Compressing logs older than 7 days..."

find "$log_dir" -type f -name "*.log" -mtime +7 \
-exec gzip {} \; 2>/dev/null

echo "Compression completed."

echo ""
echo "Deleting compressed logs older than 30 days..."

find "$log_dir" -type f -name "*.gz" -mtime +30 \
-delete 2>/dev/null

echo "Cleanup completed."