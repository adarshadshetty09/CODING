#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to find the top 5
largest files in a directory.

What this script does:
1. Searches files recursively
2. Calculates file sizes
3. Sorts files by size
4. Displays top 5 largest files
5. Helps identify disk-consuming files




find
 │
 ▼
List all files
 │
 ▼
du -h
 │
 ▼
Show file sizes
 │
 ▼
sort -rh
 │
 ▼
Largest files first
 │
 ▼
head -n 5
 │
 ▼
Top 5 largest files

=========================================================
COMMENT

# Directory to search
directory="/home/dopadm"

echo "Top 5 Largest Files:"
echo ""

find "$directory" -type f -exec du -h {} + 2>/dev/null | sort -rh | head -n 5