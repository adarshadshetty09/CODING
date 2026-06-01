#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor disk usage
across multiple servers.

What this script does:
1. Connects to remote servers using SSH
2. Retrieves disk usage information
3. Compares usage against threshold
4. Displays health report
=========================================================
COMMENT

servers=(
"server1"
"server2"
"server3"
)

threshold=80

echo "================================="
echo " MULTI SERVER DISK REPORT"
echo "================================="

for server in "${servers[@]}"
do
    usage=$(ssh "$server" \
    "df -h / | awk 'NR==2 {print \$5}' | cut -d'%' -f1")

    echo ""
    echo "Server : $server"
    echo "Disk Usage : ${usage}%"

    if [ "$usage" -gt "$threshold" ]
    then
        echo "WARNING: Disk usage exceeded ${threshold}%"
    else
        echo "Status: Healthy"
    fi
done