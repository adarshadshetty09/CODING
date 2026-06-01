#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor network
connectivity to multiple servers.

What this script does:
1. Pings multiple hosts
2. Checks network connectivity
3. Displays host status
4. Helps troubleshoot network issues
=========================================================
COMMENT

hosts=(
"google.com"
"github.com"
"amazon.com"
"8.8.8.8"
)

echo "================================="
echo " NETWORK CONNECTIVITY REPORT"
echo "================================="

for host in "${hosts[@]}"
do
    if ping -c 2 "$host" > /dev/null 2>&1
    then
        echo "✅ $host : REACHABLE"
    else
        echo "❌ $host : UNREACHABLE"
    fi
done