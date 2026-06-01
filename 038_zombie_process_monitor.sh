#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to identify zombie
processes in Linux.

What this script does:
1. Finds zombie processes
2. Counts total zombies
3. Displays zombie process details
4. Alerts if zombies are present
=========================================================
COMMENT

echo "================================="
echo " ZOMBIE PROCESS REPORT"
echo "================================="

zombie_count=$(ps -eo pid,ppid,state,comm | awk '$3=="Z"' | wc -l)

echo "Total Zombie Processes: $zombie_count"
echo ""

if [ "$zombie_count" -gt 0 ]
then
    echo "Zombie Process Details:"
    echo ""

    ps -eo pid,ppid,state,comm | awk '$3=="Z"'

    echo ""
    echo "WARNING: Zombie processes detected!"
else
    echo "No zombie processes found."
fi