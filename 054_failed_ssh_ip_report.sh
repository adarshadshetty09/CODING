#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to identify IPs with
failed SSH login attempts.

What this script does:
1. Reads authentication logs
2. Finds failed SSH login attempts
3. Extracts source IP addresses
4. Counts attempts per IP
5. Displays report sorted by highest attempts
=========================================================
COMMENT

log_file="/var/log/auth.log"

echo "================================="
echo " FAILED SSH LOGIN REPORT"
echo "================================="

grep "Failed password" "$log_file" \
| awk '{print $(NF-3)}' \
| sort \
| uniq -c \
| sort -nr