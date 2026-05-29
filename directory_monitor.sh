#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor a directory
and alert when a new file is created.

What this script does:
1. Monitors a directory continuously
2. Detects newly created files
3. Prints the name of the new file
4. Helps monitor uploads and data ingestion
=========================================================
COMMENT

# Directory to monitor
directory="/home/dopadm/uploads"

# Create directory if it doesn't exist
mkdir -p "$directory"

# Store initial file list
previous_files=$(ls "$directory" 2>/dev/null)

while true
do
    # Get current file list
    current_files=$(ls "$directory" 2>/dev/null)

    # Find newly added files
    new_files=$(comm -13 <(echo "$previous_files" | sort) <(echo "$current_files" | sort))

    # Print new file names
    if [ -n "$new_files" ]
    then
        echo "New file detected:"
        echo "$new_files"
    fi

    # Update previous file list
    previous_files="$current_files"

    sleep 5
done