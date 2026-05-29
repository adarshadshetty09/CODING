#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to count ERROR
occurrences in multiple log files.

What this script does:
1. Finds all .log files
2. Counts ERROR occurrences
3. Displays count per file
4. Helps analyze application logs
=========================================================
COMMENT

# Log directory
log_dir="/var/log"

# Find all .log files
for file in $(find "$log_dir" -type f -name "*.log")
do
    count=$(grep -c "ERROR" "$file")

    echo "$(basename "$file") : $count"
done