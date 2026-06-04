#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor system
resources and generate alerts.

What this script does:
1. Checks CPU usage
2. Checks Memory usage
3. Checks Disk usage
4. Compares usage with threshold
5. Displays alerts if usage exceeds 80%
=========================================================
COMMENT

threshold=80

echo "================================="
echo " SYSTEM RESOURCE ALERT REPORT"
echo "================================="

# Disk Usage
disk_usage=$(df -h / | awk 'NR==2 {print $5}' | cut -d'%' -f1)

# Memory Usage
memory_usage=$(free | awk '/Mem/ {printf("%.0f"), $3/$2 * 100}')

# CPU Usage
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'.' -f1)

cpu_usage=$((100 - cpu_idle))

echo ""
echo "Disk Usage   : ${disk_usage}%"
echo "Memory Usage : ${memory_usage}%"
echo "CPU Usage    : ${cpu_usage}%"

echo ""
echo "================================="
echo " ALERTS "
echo "================================="

# Disk Check
if [ "$disk_usage" -gt "$threshold" ]
then
    echo "WARNING: Disk usage exceeded ${threshold}%"
else
    echo "Disk usage is normal"
fi

# Memory Check
if [ "$memory_usage" -gt "$threshold" ]
then
    echo "WARNING: Memory usage exceeded ${threshold}%"
else
    echo "Memory usage is normal"
fi

# CPU Check
if [ "$cpu_usage" -gt "$threshold" ]
then
    echo "WARNING: CPU usage exceeded ${threshold}%"
else
    echo "CPU usage is normal"
fi