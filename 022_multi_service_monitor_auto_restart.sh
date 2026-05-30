#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor multiple
services and restart them if they are down.

What this script does:
1. Checks status of multiple services
2. Attempts restart if service is down
3. Verifies restart status
4. Displays final result
=========================================================
COMMENT

services=("nginx" "docker" "ssh")

for service in "${services[@]}"
do
    if systemctl is-active --quiet "$service"
    then
        echo "$service : Running"
    else
        echo "$service : Stopped"
        echo "Attempting restart..."

        sudo systemctl restart "$service"

        if systemctl is-active --quiet "$service"
        then
            echo "$service : Restarted Successfully"
        else
            echo "$service : Restart Failed"
        fi
    fi

    echo "---------------------------------"
done