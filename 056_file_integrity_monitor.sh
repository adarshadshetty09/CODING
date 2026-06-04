#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor critical
files and detect changes.

What this script does:
1. Calculates SHA256 checksum
2. Stores baseline checksum
3. Compares current checksum
4. Detects file modifications
5. Generates integrity report
=========================================================
COMMENT

file="/etc/passwd"
checksum_file="passwd.sha256"

# First Run: Create Baseline
if [ ! -f "$checksum_file" ]
then
    sha256sum "$file" > "$checksum_file"

    echo "Baseline checksum created."
    exit 0
fi

# Current Checksum
current_checksum=$(sha256sum "$file" | awk '{print $1}')

# Stored Checksum
stored_checksum=$(awk '{print $1}' "$checksum_file")

echo "================================="
echo " FILE INTEGRITY REPORT"
echo "================================="

if [ "$current_checksum" = "$stored_checksum" ]
then
    echo "File Integrity: OK"
else
    echo "WARNING: File has been modified!"
fi