#!/bin/bash

<<COMMENT
=========================================================
Question:
Find top 10 largest directories and
generate a disk usage report.

What this script does:
1. Scans directory usage
2. Sorts by size
3. Displays top consumers
=========================================================
COMMENT

directory="/home"

echo "================================="
echo " DISK USAGE REPORT"
echo "================================="

echo "Directory Scanned: $directory"
echo ""

du -sh "$directory"/* 2>/dev/null \
| sort -rh \
| head -10