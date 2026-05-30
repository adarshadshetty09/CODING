#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor a log file
in real time and alert when ERROR appears.

What this script does:
1. Monitors log file continuously
2. Detects ERROR messages
3. Prints alert immediately
4. Helps identify application failures
=========================================================
COMMENT

# Log file to monitor
log_file="/home/dopadm/app.log"

# Check if file exists
if [ ! -f "$log_file" ]
then
    echo "Log file not found: $log_file"
    exit 1
fi

echo "Monitoring $log_file for ERROR messages..."

tail -f "$log_file" | while read line
do
    if echo "$line" | grep -q "ERROR"
    then
        echo "ALERT: $line"
    fi
done