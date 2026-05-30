#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor CPU usage.

What this script does:
1. Checks total CPU usage percentage
2. Calculates current CPU utilization
3. Compares usage with threshold value
4. Displays warning if CPU exceeds 80%
5. Displays normal status otherwise
=========================================================
COMMENT

# Get CPU idle percentage
idle=$(top -bn1 | grep "Cpu(s)" | awk -F',' '{print $4}' | awk '{print $1}' | cut -d'.' -f1)

# Calculate CPU usage
usage=$((100 - idle))

# Compare CPU usage with threshold
if [ "$usage" -gt 80 ]
then
    echo "WARNING: CPU usage is high: ${usage}%"
else
    echo "CPU usage is normal: ${usage}%"
fi