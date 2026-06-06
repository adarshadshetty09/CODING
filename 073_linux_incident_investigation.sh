#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to investigate a
Linux production incident.

What this script does:
1. Checks CPU usage
2. Checks memory usage
3. Checks disk usage
4. Checks load average
5. Lists top CPU processes
6. Lists network connections
7. Checks service status
8. Shows recent errors
=========================================================
COMMENT

service="nginx"

echo "================================================="
echo " LINUX INCIDENT INVESTIGATION REPORT"
echo "================================================="

#########################################################
# CPU Usage
#########################################################

echo ""
echo "================ CPU ================="

top -bn1 | head -5

#########################################################
# Memory
#########################################################

echo ""
echo "=============== MEMORY ==============="

free -h

#########################################################
# Disk
#########################################################

echo ""
echo "================ DISK ================"

df -h

#########################################################
# Load Average
#########################################################

echo ""
echo "============ LOAD AVERAGE ============"

uptime

#########################################################
# Top CPU Processes
#########################################################

echo ""
echo "=========== TOP CPU PROCESSES ========"

ps -eo pid,comm,%cpu --sort=-%cpu | head -10

#########################################################
# Network Connections
#########################################################

echo ""
echo "========== NETWORK CONNECTIONS ======="

ss -tulnp | head

#########################################################
# Service Status
#########################################################

echo ""
echo "=========== SERVICE STATUS ==========="

systemctl status "$service" --no-pager -l | head -15

#########################################################
# Recent Errors
#########################################################

echo ""
echo "============ RECENT ERRORS ==========="

journalctl -p err -n 20 --no-pager

echo ""
echo "================================================="
echo " INVESTIGATION COMPLETED"
echo "================================================="