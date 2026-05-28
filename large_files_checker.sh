#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to find files larger
than 100MB inside a directory.

What this script does:
1. Searches files recursively
2. Finds files larger than 100MB
3. Displays file names and sizes
4. Helps identify disk-consuming files
=========================================================
COMMENT

# Directory to search
search_dir="/home/dopadm"

echo "Large files found:"
echo ""

# Find files larger than 100MB
find "$search_dir" -type f -size +100M -exec ls -lh {} \;