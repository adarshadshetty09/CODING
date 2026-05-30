#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to check whether
multiple ports are open.

What this script does:
1. Checks connectivity to multiple ports
2. Displays OPEN or CLOSED status
3. Helps validate service availability
4. Useful for troubleshooting
=========================================================
COMMENT

# Target host
host="localhost"

# Common DevOps Ports
ports=(
22      # SSH
21      # FTP
25      # SMTP
53      # DNS
80      # HTTP
110     # POP3
123     # NTP
143     # IMAP
443     # HTTPS
465     # SMTPS
587     # SMTP Submission
993     # IMAPS
995     # POP3S
3306    # MySQL
5432    # PostgreSQL
6379    # Redis
8080    # Tomcat/App
8443    # HTTPS Alternate
9090    # Prometheus
9042    # Cassandra
)

echo "================================="
echo " PORT STATUS REPORT"
echo "================================="

for port in "${ports[@]}"
do
    if nc -z "$host" "$port" 2>/dev/null
    then
        echo "Port $port : OPEN"
    else
        echo "Port $port : CLOSED"
    fi
done