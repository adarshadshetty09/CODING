#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a reusable Linux Server Health
Framework.

Scenario:
The company manages more than 200 Linux
servers.

Currently engineers manually execute
multiple commands during incidents:

df -h
free -h
top
uptime
systemctl

This process is slow and inconsistent.

Management wants a standardized health
check framework that can be executed on
any server and generate a health report.

The framework should provide:

- CPU Status
- Memory Status
- Disk Status
- Load Average
- Service Status
- Uptime

Purpose:
Provide a reusable server health framework
for operations, troubleshooting and audits.

What this script does:
1. Collects CPU information
2. Collects memory information
3. Collects disk usage
4. Collects load average
5. Collects uptime
6. Checks critical services
7. Generates health report

Prerequisites:
- Linux Server
- systemctl available

Expected Output:
server_health_report.txt

Overall Status:
HEALTHY / WARNING / CRITICAL

Real-world Use Case:
Used by DevOps Engineers, SREs and
Operations teams during incidents and
health reviews.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

report_file="server_health_report.txt"

critical_services=(
sshd
docker
nginx
)

health_score=100

# =====================================================
# Report Header
# =====================================================

{
echo "========================================="
echo " SERVER HEALTH REPORT"
echo "========================================="
echo "Hostname : $(hostname)"
echo "Generated: $(date)"
echo
} > "$report_file"

# =====================================================
# CPU Check
# =====================================================

cpu_usage=$(top -bn1 | grep "Cpu(s)" \
| awk '{print 100-$8}')

echo "===== CPU USAGE =====" \
>> "$report_file"

echo "CPU Usage: ${cpu_usage}%" \
>> "$report_file"

cpu_int=${cpu_usage%.*}

if [ "$cpu_int" -gt 90 ]
then
    health_score=$((health_score-20))
fi

# =====================================================
# Memory Check
# =====================================================

memory_usage=$(free | awk '
/Mem/ {
printf("%.0f",$3/$2*100)
}')

echo >> "$report_file"
echo "===== MEMORY =====" \
>> "$report_file"

echo "Memory Usage: ${memory_usage}%" \
>> "$report_file"

if [ "$memory_usage" -gt 90 ]
then
    health_score=$((health_score-20))
fi

# =====================================================
# Disk Check
# =====================================================

echo >> "$report_file"
echo "===== DISK USAGE =====" \
>> "$report_file"

while read filesystem usage
do
    echo "$filesystem $usage" \
    >> "$report_file"

    percent=$(echo "$usage" | tr -d '%')

    if [ "$percent" -gt 90 ]
    then
        health_score=$((health_score-10))
    fi

done < <(
df -hP | awk '
NR>1 {
print $6,$5
}'
)

# =====================================================
# Load Average
# =====================================================

echo >> "$report_file"
echo "===== LOAD AVERAGE =====" \
>> "$report_file"

uptime | awk -F'load average:' \
'{print $2}' >> "$report_file"

# =====================================================
# Uptime
# =====================================================

echo >> "$report_file"
echo "===== UPTIME =====" \
>> "$report_file"

uptime -p >> "$report_file"

# =====================================================
# Service Check
# =====================================================

echo >> "$report_file"
echo "===== SERVICE STATUS =====" \
>> "$report_file"

for service in "${critical_services[@]}"
do

    if systemctl is-active --quiet "$service"
    then
        echo "$service : RUNNING" \
        >> "$report_file"
    else
        echo "$service : STOPPED" \
        >> "$report_file"

        health_score=$((health_score-15))
    fi

done

# =====================================================
# Final Health Assessment
# =====================================================

echo >> "$report_file"

if [ "$health_score" -ge 80 ]
then
    overall="HEALTHY"
elif [ "$health_score" -ge 60 ]
then
    overall="WARNING"
else
    overall="CRITICAL"
fi

{
echo "========================================="
echo " FINAL RESULT"
echo "========================================="
echo "Health Score : $health_score"
echo "Overall Status : $overall"
} >> "$report_file"

# =====================================================
# Completion
# =====================================================

echo
echo "Framework Execution Complete"
echo "Report Generated:"
echo "$report_file"

echo "Overall Status: $overall"