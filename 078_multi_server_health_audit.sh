#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to collect health
information from multiple Linux servers.

Purpose:
Help DevOps/SRE engineers audit server health
across infrastructure environments.

What this script does:
1. Connects to multiple servers via SSH
2. Collects CPU load
3. Collects memory usage
4. Collects disk usage
5. Collects uptime
6. Generates CSV report

Prerequisites:
- SSH access configured
- Passwordless SSH keys
- Linux servers reachable

Expected Output:
server_health_report.csv

Server,CPU_Load,Memory_Usage,Disk_Usage,Uptime

Real-world Use Case:
Used for infrastructure audits,
capacity reviews and daily health checks.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

servers=(
web01
web02
web03
app01
db01
)

report_file="server_health_report.csv"

# =====================================================
# CSV Header
# =====================================================

echo "Server,CPU_Load,Memory_Usage,Disk_Usage,Uptime" > "$report_file"

# =====================================================
# Collect Health Information
# =====================================================

for server in "${servers[@]}"
do
    echo "Checking $server..."

    cpu=$(ssh "$server" \
    "uptime | awk -F'load average:' '{print \$2}' | cut -d',' -f1")

    memory=$(ssh "$server" \
    "free | awk '/Mem/ {printf(\"%.0f%%\",\$3/\$2*100)}'")

    disk=$(ssh "$server" \
    "df / | awk 'NR==2 {print \$5}'")

    uptime=$(ssh "$server" \
    "uptime -p")

    echo "$server,$cpu,$memory,$disk,\"$uptime\"" \
    >> "$report_file"

done

# =====================================================
# Completion Message
# =====================================================

echo
echo "Report Generated:"
echo "$report_file"