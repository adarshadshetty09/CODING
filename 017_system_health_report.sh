#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to generate a
system health report.

What this script does:
1. Collects hostname information
2. Collects current date and time
3. Collects disk usage
4. Collects memory usage
5. Collects CPU usage
6. Saves report to a file
=========================================================
COMMENT

report_file="health_report.txt"

echo "=================================" > "$report_file"
echo "      SYSTEM HEALTH REPORT" >> "$report_file"
echo "=================================" >> "$report_file"

echo "Hostname: $(hostname)" >> "$report_file"
echo "Date: $(date)" >> "$report_file"

echo "" >> "$report_file"
echo "Disk Usage:" >> "$report_file"
df -h / >> "$report_file"

echo "" >> "$report_file"
echo "Memory Usage:" >> "$report_file"
free -h >> "$report_file"

echo "" >> "$report_file"
echo "CPU Usage:" >> "$report_file"
top -bn1 | grep "Cpu(s)" >> "$report_file"

echo "" >> "$report_file"
echo "Report generated successfully."
echo "File: $report_file"