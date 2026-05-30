#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to display the
top 5 memory-consuming processes.

What this script does:
1. Retrieves running processes
2. Sorts by memory usage
3. Displays top 5 memory-consuming processes
4. Helps identify memory bottlenecks
=========================================================
COMMENT

echo "================================="
echo " TOP 5 MEMORY CONSUMING PROCESSES"
echo "================================="

ps -eo pid,comm,%mem --sort=-%mem | head -n 6