#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor services
across multiple servers.

What this script does:
1. Connects to remote servers via SSH
2. Checks service status
3. Attempts restart if service is down
4. Displays service health report
=========================================================
COMMENT

servers=(
"server1"
"server2"
"server3"
)

services=(
"nginx"
"docker"
"ssh"
)

echo "================================="
echo " MULTI SERVER SERVICE REPORT"
echo "================================="

for server in "${servers[@]}"
do
    echo ""
    echo "Server: $server"
    echo "---------------------------------"

    for service in "${services[@]}"
    do
        if ssh "$server" "systemctl is-active --quiet $service"
        then
            echo "$service : RUNNING"
        else
            echo "$service : STOPPED"
            echo "Attempting restart..."

            ssh "$server" "sudo systemctl restart $service"

            if ssh "$server" "systemctl is-active --quiet $service"
            then
                echo "$service : RESTARTED SUCCESSFULLY"
            else
                echo "$service : RESTART FAILED"
            fi
        fi
    done
done