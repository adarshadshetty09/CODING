#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor failed
SSH login attempts from authentication logs.

What this script does:
1. Reads authentication log file
2. Searches failed SSH login attempts
3. Counts total failed logins
4. Displays failed login details
5. Helps identify unauthorized access attempts
=========================================================
COMMENT

# Authentication log file
log_file="/var/log/auth.log"

# Count failed login attempts
failed_count=$(grep -c "Failed password" "$log_file")

# Display total failed login attempts
echo "Total Failed Login Attempts: $failed_count"
echo ""

# Display failed login details
echo "Failed Login Details:"
echo ""

grep "Failed password" "$log_file"