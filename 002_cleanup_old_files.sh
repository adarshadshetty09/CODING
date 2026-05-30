#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to find and delete
files older than 30 days.

What this script does:
1. Searches files older than 30 days
2. Displays matching files
3. Deletes old files
4. Helps reclaim disk space
=========================================================
COMMENT

# Directory to clean
directory="/tmp"

echo "Files older than 30 days:"

find "$directory" -type f -mtime +30

echo ""
echo "Deleting files..."

find "$directory" -type f -mtime +30 -delete

echo "Cleanup completed."