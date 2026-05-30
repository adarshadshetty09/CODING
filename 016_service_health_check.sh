#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor service health
and restart the service if it is down.

What this script does:
1. Checks whether nginx service is running
2. Displays service status
3. Attempts to restart service if it is down
4. Verifies whether restart was successful
5. Displays success or failure message
=========================================================
COMMENT

# Service name
service="nginx"

# Check whether service is running
if systemctl is-active --quiet "$service"
then
    echo "$service service is running"
else
    echo "$service service is down"
    echo "Attempting to restart..."

    # Restart service
    sudo systemctl restart "$service"

    # Verify service restart status
    if systemctl is-active --quiet "$service"
    then
        echo "$service restarted successfully"
    else
        echo "Failed to restart $service"
    fi
fi