#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to generate a daily
server health dashboard.

What this script does:
1. Displays hostname
2. Displays current date/time
3. Displays CPU usage
4. Displays memory usage
5. Displays disk usage
6. Displays top 5 CPU-consuming processes
7. Displays service status
8. Generates a complete health report
=========================================================
COMMENT

echo "========================================="
echo "      DAILY SERVER HEALTH DASHBOARD"
echo "========================================="

echo ""
echo "Hostname : $(hostname)"
echo "Date     : $(date)"

echo ""
echo "========================================="
echo "CPU USAGE"
echo "========================================="

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')

echo "CPU Usage : ${cpu_usage}%"

echo ""
echo "========================================="
echo "MEMORY USAGE"
echo "========================================="

memory_usage=$(free | awk '/Mem/ {printf("%.0f"), $3/$2 * 100}')

echo "Memory Usage : ${memory_usage}%"

echo ""
echo "========================================="
echo "DISK USAGE"
echo "========================================="

df -h /

echo ""
echo "========================================="
echo "TOP 5 CPU PROCESSES"
echo "========================================="

ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

echo ""
echo "========================================="
echo "SERVICE STATUS"
echo "========================================="

services=("nginx" "docker" "ssh")

for service in "${services[@]}"
do
    if systemctl is-active --quiet "$service"
    then
        echo "$service : RUNNING"
    else
        echo "$service : STOPPED"
    fi
done

echo ""
echo "========================================="
echo "HEALTH CHECK COMPLETED"
echo "========================================="