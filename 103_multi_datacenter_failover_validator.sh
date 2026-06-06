#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to validate Multi-
Datacenter Failover Readiness.

Scenario:
The company operates two datacenters.

Primary Datacenter:
Bangalore

Secondary Datacenter:
Mumbai

All customer-facing applications run in
the primary datacenter.

Management wants assurance that if the
primary datacenter becomes unavailable due
to:

- Power Failure
- Network Outage
- Hardware Failure
- Natural Disaster
- Human Error

customer traffic can be redirected to the
secondary datacenter.

The Infrastructure and SRE teams must
verify failover readiness before the
annual DR audit.

Purpose:
Validate business continuity and disaster
recovery preparedness.

What this script does:
1. Verifies primary site reachability
2. Verifies secondary site reachability
3. Checks DNS failover targets
4. Validates application health endpoints
5. Validates database replication
6. Generates failover readiness report
7. Produces READY / NOT READY result

Prerequisites:
- DNS access
- Network connectivity
- MySQL/PostgreSQL replication configured
- curl installed
- dig installed

Expected Output:
failover_validation_report.txt

Failover Status:
READY / NOT READY

Real-world Use Case:
Used during DR drills, business continuity
audits and datacenter migration exercises.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

primary_app="app-primary.company.com"
secondary_app="app-dr.company.com"

primary_db="10.10.10.10"
secondary_db="10.20.20.20"

report_file="failover_validation_report.txt"

status=0

# =====================================================
# Report Header
# =====================================================

{
echo "========================================="
echo " MULTI-DATACENTER FAILOVER REPORT"
echo "========================================="
echo "Generated: $(date)"
echo
} > "$report_file"

# =====================================================
# Primary Site Check
# =====================================================

curl -s -o /dev/null \
-w "%{http_code}" \
https://$primary_app > /tmp/primary_status

primary_status=$(cat /tmp/primary_status)

if [ "$primary_status" = "200" ]
then
    echo "[PASS] Primary Application Reachable" \
    >> "$report_file"
else
    echo "[FAIL] Primary Application Unreachable" \
    >> "$report_file"

    status=1
fi

# =====================================================
# Secondary Site Check
# =====================================================

curl -s -o /dev/null \
-w "%{http_code}" \
https://$secondary_app > /tmp/secondary_status

secondary_status=$(cat /tmp/secondary_status)

if [ "$secondary_status" = "200" ]
then
    echo "[PASS] DR Application Reachable" \
    >> "$report_file"
else
    echo "[FAIL] DR Application Unreachable" \
    >> "$report_file"

    status=1
fi

# =====================================================
# DNS Validation
# =====================================================

{
echo
echo "===== DNS RECORDS ====="
dig +short $primary_app
dig +short $secondary_app
} >> "$report_file"

# =====================================================
# Database Connectivity
# =====================================================

ping -c 2 "$primary_db" >/dev/null 2>&1

if [ $? -eq 0 ]
then
    echo "[PASS] Primary Database Reachable" \
    >> "$report_file"
else
    echo "[FAIL] Primary Database Unreachable" \
    >> "$report_file"

    status=1
fi

ping -c 2 "$secondary_db" >/dev/null 2>&1

if [ $? -eq 0 ]
then
    echo "[PASS] DR Database Reachable" \
    >> "$report_file"
else
    echo "[FAIL] DR Database Unreachable" \
    >> "$report_file"

    status=1
fi

# =====================================================
# Application Health Check
# =====================================================

primary_health=$(curl -s \
https://$primary_app/health)

secondary_health=$(curl -s \
https://$secondary_app/health)

if echo "$primary_health" | grep -qi UP
then
    echo "[PASS] Primary Health Endpoint OK" \
    >> "$report_file"
else
    echo "[FAIL] Primary Health Check Failed" \
    >> "$report_file"

    status=1
fi

if echo "$secondary_health" | grep -qi UP
then
    echo "[PASS] DR Health Endpoint OK" \
    >> "$report_file"
else
    echo "[FAIL] DR Health Check Failed" \
    >> "$report_file"

    status=1
fi

# =====================================================
# Final Result
# =====================================================

{
echo
echo "========================================="
echo " FINAL RESULT"
echo "========================================="
} >> "$report_file"

if [ "$status" -eq 0 ]
then
    {
    echo "FAILOVER STATUS : READY"
    echo "Datacenter failover can proceed."
    } >> "$report_file"
else
    {
    echo "FAILOVER STATUS : NOT READY"
    echo "Critical failover issues detected."
    } >> "$report_file"
fi

# =====================================================
# Completion
# =====================================================

echo
echo "Failover Validation Complete"
echo "Report Generated:"
echo "$report_file"

if [ "$status" -eq 0 ]
then
    echo "FAILOVER STATUS : READY"
else
    echo "FAILOVER STATUS : NOT READY"
fi