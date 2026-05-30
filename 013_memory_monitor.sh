#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor system memory usage.

What this script does:
1. Checks total memory usage
2. Calculates memory usage percentage
3. Compares usage with threshold value
4. Displays warning if memory usage exceeds 80%
5. Displays normal message otherwise
=========================================================
COMMENT

# Get memory usage percentage
usage=$(free | awk '/Mem/ {printf("%.0f"), $3/$2 * 100}')

# Compare memory usage with threshold value
if [ "$usage" -gt 80 ]
then
    echo "WARNING: Memory usage is high: ${usage}%"
else
    echo "Memory usage is normal: ${usage}%"
fi