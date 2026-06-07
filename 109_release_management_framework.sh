#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a reusable Release Management
Framework for production deployments.

Scenario:
Friday 8:00 PM

A major production deployment is scheduled.

The release includes:

- Application Changes
- Database Changes
- Infrastructure Changes

Management, Product Owners and Engineering
Leads are waiting for a deployment decision.

A failed release could impact thousands
of customers.

Before deployment, the Platform Engineering
team must validate:

- Application Health
- Service Health
- Database Connectivity
- Disk Capacity
- Rollback Readiness
- Monitoring Availability

The team requires a GO / NO-GO decision
based on objective validation checks.

Purpose:
Reduce deployment risk and improve release
quality.

What this script does:
1. Checks application health endpoint
2. Checks critical services
3. Checks database connectivity
4. Checks disk utilization
5. Checks rollback artifacts
6. Checks monitoring availability
7. Generates release validation report
8. Produces GO / NO-GO decision

Prerequisites:
- Linux server
- curl installed
- systemctl available
- Database client installed

Expected Output:
release_management_report.txt

Release Decision:
GO / NO-GO

Real-world Use Case:
Used by DevOps Engineers, Platform Teams,
Release Managers and SREs before major
production deployments.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

report_file="release_management_report.txt"

app_url="http://localhost:8080/health"

rollback_dir="/opt/releases"

monitoring_url="http://localhost:9090/-/healthy"

critical_services=(
nginx
docker
)

failed_checks=0

# =====================================================
# Report Header
# =====================================================

{
echo "========================================="
echo " RELEASE MANAGEMENT REPORT"
echo "========================================="
echo "Generated: $(date)"
echo
} > "$report_file"

# =====================================================
# Application Health Check
# =====================================================

http_code=$(curl -s -o /dev/null \
-w "%{http_code}" "$app_url")

if [ "$http_code" = "200" ]
then
    echo "[PASS] Application Health Check" \
    >> "$report_file"
else
    echo "[FAIL] Application Health Check" \
    >> "$report_file"

    failed_checks=$((failed_checks+1))
fi

# =====================================================
# Service Validation
# =====================================================

echo >> "$report_file"
echo "===== SERVICES =====" \
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

        failed_checks=$((failed_checks+1))
    fi

done

# =====================================================
# Database Connectivity
# =====================================================

mysqladmin ping \
>/dev/null 2>&1

if [ $? -eq 0 ]
then
    echo "[PASS] Database Reachable" \
    >> "$report_file"
else
    echo "[FAIL] Database Unreachable" \
    >> "$report_file"

    failed_checks=$((failed_checks+1))
fi

# =====================================================
# Disk Capacity Check
# =====================================================

disk_usage=$(df -h / | awk '
NR==2 {
gsub("%","",$5)
print $5
}')

echo >> "$report_file"
echo "Disk Usage : ${disk_usage}%" \
>> "$report_file"

if [ "$disk_usage" -gt 85 ]
then
    echo "[FAIL] Low Disk Capacity" \
    >> "$report_file"

    failed_checks=$((failed_checks+1))
fi

# =====================================================
# Rollback Validation
# =====================================================

latest_release=$(ls -1 "$rollback_dir" \
2>/dev/null | wc -l)

if [ "$latest_release" -gt 0 ]
then
    echo "[PASS] Rollback Artifacts Available" \
    >> "$report_file"
else
    echo "[FAIL] No Rollback Artifacts Found" \
    >> "$report_file"

    failed_checks=$((failed_checks+1))
fi

# =====================================================
# Monitoring Validation
# =====================================================

monitoring_status=$(curl -s \
-o /dev/null \
-w "%{http_code}" \
"$monitoring_url")

if [ "$monitoring_status" = "200" ]
then
    echo "[PASS] Monitoring Available" \
    >> "$report_file"
else
    echo "[FAIL] Monitoring Unavailable" \
    >> "$report_file"

    failed_checks=$((failed_checks+1))
fi

# =====================================================
# Final Decision
# =====================================================

{
echo
echo "========================================="
echo " RELEASE DECISION"
echo "========================================="
} >> "$report_file"

if [ "$failed_checks" -eq 0 ]
then

    {
    echo "GO"
    echo "Release Approved"
    } >> "$report_file"

else

    {
    echo "NO-GO"
    echo "Release Blocked"
    echo "Failed Checks : $failed_checks"
    } >> "$report_file"

fi

# =====================================================
# Completion
# =====================================================

echo
echo "Release Management Framework Complete"
echo "Report Generated:"
echo "$report_file"

if [ "$failed_checks" -eq 0 ]
then
    echo "Release Decision: GO"
else
    echo "Release Decision: NO-GO"
fi