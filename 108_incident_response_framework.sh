#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a reusable Incident Response
Framework for Linux production systems.

Scenario:
02:17 AM

PagerDuty Alert Triggered

"Customer checkout failures detected"

Customers are unable to place orders.

Management joins the bridge call and asks:

- What failed?
- What systems are affected?
- What is the customer impact?
- What should we do next?

Engineers begin manually running:

top
free -h
df -h
systemctl
journalctl
ping

The process is slow and different
engineers collect different information.

The SRE team wants a standardized incident
response framework that gathers critical
troubleshooting information automatically.

Purpose:
Reduce Mean Time To Resolution (MTTR)
during production incidents.

What this script does:
1. Collects CPU usage
2. Collects memory usage
3. Collects disk usage
4. Checks critical services
5. Collects recent errors
6. Tests network connectivity
7. Generates incident report
8. Calculates severity score

Prerequisites:
- Linux server
- systemctl available
- journalctl available

Expected Output:
incident_response_report.txt

Severity:
LOW / MEDIUM / HIGH / CRITICAL

Real-world Use Case:
Used by SREs, DevOps Engineers and
Operations teams during production
incident investigations.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

report_file="incident_response_report.txt"

critical_services=(
nginx
docker
sshd
)

severity_score=0

# =====================================================
# Report Header
# =====================================================

{
echo "========================================="
echo " INCIDENT RESPONSE REPORT"
echo "========================================="
echo "Hostname : $(hostname)"
echo "Generated: $(date)"
echo
} > "$report_file"

# =====================================================
# CPU Analysis
# =====================================================

cpu_usage=$(top -bn1 | awk '
/Cpu\(s\)/ {
print int(100-$8)
}')

{
echo "===== CPU ====="
echo "CPU Usage : ${cpu_usage}%"
echo
} >> "$report_file"

if [ "$cpu_usage" -gt 90 ]
then
    severity_score=$((severity_score+20))
fi

# =====================================================
# Memory Analysis
# =====================================================

memory_usage=$(free | awk '
/Mem/ {
printf("%.0f",$3/$2*100)
}')

{
echo "===== MEMORY ====="
echo "Memory Usage : ${memory_usage}%"
echo
} >> "$report_file"

if [ "$memory_usage" -gt 90 ]
then
    severity_score=$((severity_score+20))
fi

# =====================================================
# Disk Analysis
# =====================================================

{
echo "===== DISK ====="
} >> "$report_file"

while read mount usage
do

    echo "$mount : $usage" \
    >> "$report_file"

    percent=$(echo "$usage" | tr -d '%')

    if [ "$percent" -gt 90 ]
    then
        severity_score=$((severity_score+10))
    fi

done < <(
df -hP | awk '
NR>1 {
print $6,$5
}'
)

echo >> "$report_file"

# =====================================================
# Service Validation
# =====================================================

{
echo "===== SERVICES ====="
} >> "$report_file"

for service in "${critical_services[@]}"
do

    if systemctl is-active --quiet "$service"
    then
        echo "$service : RUNNING" \
        >> "$report_file"
    else
        echo "$service : STOPPED" \
        >> "$report_file"

        severity_score=$((severity_score+20))
    fi

done

echo >> "$report_file"

# =====================================================
# Recent System Errors
# =====================================================

{
echo "===== RECENT ERRORS ====="

journalctl -p err -n 20 \
--no-pager

echo
} >> "$report_file"

# =====================================================
# Network Connectivity
# =====================================================

{
echo "===== NETWORK ====="
} >> "$report_file"

for host in 8.8.8.8 google.com
do

    if ping -c 2 "$host" \
    >/dev/null 2>&1
    then
        echo "$host : REACHABLE" \
        >> "$report_file"
    else
        echo "$host : UNREACHABLE" \
        >> "$report_file"

        severity_score=$((severity_score+15))
    fi

done

echo >> "$report_file"

# =====================================================
# Severity Assessment
# =====================================================

if [ "$severity_score" -ge 60 ]
then
    severity="CRITICAL"
elif [ "$severity_score" -ge 40 ]
then
    severity="HIGH"
elif [ "$severity_score" -ge 20 ]
then
    severity="MEDIUM"
else
    severity="LOW"
fi

{
echo "========================================="
echo " FINAL RESULT"
echo "========================================="
echo "Severity Score : $severity_score"
echo "Incident Severity : $severity"
} >> "$report_file"

# =====================================================
# Completion
# =====================================================

echo
echo "Incident Response Framework Complete"
echo "Report Generated:"
echo "$report_file"

echo "Incident Severity: $severity"