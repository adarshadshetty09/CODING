#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor multiple
Docker containers and restart them if down.

What this script does:
1. Checks multiple container statuses
2. Detects stopped containers
3. Attempts automatic restart
4. Verifies restart status
5. Demonstrates self-healing automation
=========================================================
COMMENT

containers=("nginx" "redis" "postgres")

echo "================================="
echo " DOCKER CONTAINER HEALTH REPORT"
echo "================================="

for container in "${containers[@]}"
do
    if docker ps --format "{{.Names}}" | grep -w "$container" > /dev/null
    then
        echo "$container : RUNNING"
    else
        echo "$container : STOPPED"
        echo "Attempting restart..."

        docker start "$container" > /dev/null 2>&1

        if docker ps --format "{{.Names}}" | grep -w "$container" > /dev/null
        then
            echo "$container : RESTARTED SUCCESSFULLY"
        else
            echo "$container : RESTART FAILED"
        fi
    fi

    echo "---------------------------------"
done