#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to check whether a
specific file exists.

What this script does:
1. Checks file existence
2. Displays file status
3. Prints alert if file is missing
4. Helps monitor critical files
=========================================================
COMMENT

# File to monitor
file="/home/dopadm/app.log"

# Check file existence
if [ -f "$file" ]
then
    echo "File found: $file"
else
    echo "ALERT: File not found: $file"
fi