#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to find the top 10
largest directories in a system.

What this script does:
1. Calculates directory sizes
2. Sorts directories by size
3. Displays top 10 largest directories
4. Helps identify disk consumers
=========================================================
COMMENT

directory="/"

echo "================================="
echo " TOP 10 LARGEST DIRECTORIES"
echo "================================="

du -sh "$directory"/* 2>/dev/null | sort -rh | head -10