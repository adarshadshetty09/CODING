#!/bin/bash

echo "PID     PROCESS     CPU%"

ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# -e → all processes
# -o → custom output format
# pid → process ID
# comm → process name
# %cpu → CPU usage

# --sort=-%cpu - means descending order highest CPU usage first

# head -n 6 
# First line = header Next 5 lines = top 5 processes

