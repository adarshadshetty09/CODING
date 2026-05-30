#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to display the
top 5 CPU-consuming processes.

What this script does:
1. Displays process ID (PID)
2. Displays process name
3. Displays CPU usage percentage
4. Sorts processes by highest CPU usage
5. Shows top 5 CPU-consuming processes
=========================================================
COMMENT

# Display column headers
echo "PID     PROCESS     CPU%"

# Display top 5 CPU-consuming processes
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# Explanation:
# -e            → Display all running processes
# -o            → Custom output format
# pid           → Process ID
# comm          → Process name
# %cpu          → CPU usage percentage

# --sort=-%cpu  → Sort in descending order
#                 Highest CPU usage appears first

# head -n 6     → Display first 6 lines
#                 1 header line + top 5 processes