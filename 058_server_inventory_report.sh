#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to generate a server
inventory report.

What this script does:
1. Displays hostname
2. Displays IP address
3. Displays OS version
4. Displays CPU count
5. Displays total memory
6. Displays disk size
7. Displays uptime
8. Generates inventory report
=========================================================
COMMENT

echo "========================================="
echo " SERVER INVENTORY REPORT"
echo "========================================="

echo ""
echo "Hostname        : $(hostname)"

echo "IP Address      : $(hostname -I | awk '{print $1}')"

echo "OS Version      : $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')"

echo "Kernel Version  : $(uname -r)"

echo "CPU Count       : $(nproc)"

echo "Total Memory    : $(free -h | awk '/Mem:/ {print $2}')"

echo "Disk Size       : $(df -h / | awk 'NR==2 {print $2}')"

echo "Disk Used       : $(df -h / | awk 'NR==2 {print $3}')"

echo "Disk Available  : $(df -h / | awk 'NR==2 {print $4}')"

echo "System Uptime   : $(uptime -p)"

echo ""
echo "========================================="
echo " REPORT GENERATED SUCCESSFULLY"
echo "========================================="