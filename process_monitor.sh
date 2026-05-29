#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to check whether a
process is running and start it if not.

What this script does:
1. Checks process status
2. Starts service if process is down
3. Verifies startup status
4. Displays result
=========================================================
COMMENT

process="$1"

if pgrep "$process" > /dev/null
then
    echo "Process $process is running"
else
    echo "Process $process is not running"
    echo "Attempting to start $process..."

    sudo systemctl start "$process"

    if pgrep "$process" > /dev/null
    then
        echo "$process started successfully"
    else
        echo "Failed to start $process"
    fi
fi