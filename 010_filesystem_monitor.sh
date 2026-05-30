#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor disk usage
of all mounted filesystems.

What this script does:
1. Reads filesystem usage information
2. Checks usage percentage
3. Compares usage against threshold (80%)
4. Displays warning for high-usage filesystems
5. Helps prevent disk space issues
=========================================================
COMMENT

threshold=80
flag=0

df -h | awk 'NR>1 {print $5, $6}' | while read usage mount
do
    usage=$(echo "$usage" | cut -d'%' -f1)

    if [ "$usage" -gt "$threshold" ]
    then
        echo "WARNING: $mount is ${usage}% full"
        flag=1
    fi
done

if [ "$flag" -eq 0 ]
then
    echo "All filesystems are within threshold."
fi