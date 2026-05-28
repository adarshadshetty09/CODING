#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor disk usage
of the root filesystem (/).

What this script does:
1. Checks disk usage percentage
2. Extracts usage value
3. Compares usage with threshold value
4. Displays warning if usage exceeds 80%
5. Displays normal message otherwise
=========================================================
COMMENT

# Get disk usage percentage of root filesystem (/)
usage=$(df -h / | awk 'NR==2 {print $5}' | cut -d'%' -f1)

# Compare disk usage with threshold value
if [ "$usage" -gt 80 ]
then
    echo "WARNING: Disk usage exceeded threshold: ${usage}%"
else
    echo "Disk usage is normal: ${usage}%"
fi