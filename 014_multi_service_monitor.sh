#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor multiple
services and display their status.

What this script does:
1. Checks status of multiple services
2. Displays whether each service is running
3. Helps monitor critical infrastructure
4. Can be extended for auto-restart
=========================================================
COMMENT

# List of services to monitor
services=("nginx" "docker" "ssh")

echo "================================="
echo "     SERVICE HEALTH REPORT"
echo "================================="

for service in "${services[@]}"
do
    if systemctl is-active --quiet "$service"
    then
        echo "$service : Running"
    else
        echo "$service : Stopped"
    fi
done