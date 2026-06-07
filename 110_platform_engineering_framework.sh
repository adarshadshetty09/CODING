#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a Platform Engineering Framework
that provides a unified operational view
of the technology platform.

Scenario:
The company has grown significantly.

Current Environment:

- 300 Linux Servers
- 100 AWS Accounts
- 40 Kubernetes Clusters
- 20 Jenkins Controllers
- Multiple Databases

Every team has its own dashboard.

Management complains:

"We have 20 dashboards but no single
view of platform health."

During incidents, leadership asks:

- Are servers healthy?
- Is AWS healthy?
- Is Kubernetes healthy?
- Is CI/CD healthy?
- Are databases healthy?

The Platform Engineering team must build
a framework that generates a consolidated
Executive Platform Health Report.

Purpose:
Provide a centralized platform health
assessment across multiple technologies.

What this script does:
1. Collects Linux health
2. Collects AWS health
3. Collects Kubernetes health
4. Collects CI/CD health
5. Collects Database health
6. Calculates platform score
7. Generates executive report

Prerequisites:
- Linux server
- AWS CLI configured
- kubectl configured
- Jenkins API access
- Database access

Expected Output:
platform_health_report.txt

Platform Status:
HEALTHY / WARNING / CRITICAL

Real-world Use Case:
Used by Platform Engineers, Principal
Engineers, Staff SREs and Engineering
Leadership teams.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

report_file="platform_health_report.txt"

platform_score=100

# =====================================================
# Report Header
# =====================================================

{
echo "========================================="
echo " EXECUTIVE PLATFORM HEALTH REPORT"
echo "========================================="
echo "Generated: $(date)"
echo
} > "$report_file"

# =====================================================
# Linux Health
# =====================================================

cpu_usage=$(top -bn1 | awk '
/Cpu\(s\)/ {
print int(100-$8)
}')

memory_usage=$(free | awk '
/Mem/ {
printf("%.0f",$3/$2*100)
}')

{
echo "===== LINUX ====="
echo "CPU Usage    : ${cpu_usage}%"
echo "Memory Usage : ${memory_usage}%"
echo
} >> "$report_file"

if [ "$cpu_usage" -gt 90 ]
then
    platform_score=$((platform_score-10))
fi

if [ "$memory_usage" -gt 90 ]
then
    platform_score=$((platform_score-10))
fi

# =====================================================
# AWS Health
# =====================================================

running_instances=$(aws ec2 describe-instances \
--filters Name=instance-state-name,Values=running \
--query 'Reservations[*].Instances[*].InstanceId' \
--output text 2>/dev/null | wc -w)

{
echo "===== AWS ====="
echo "Running Instances : $running_instances"
echo
} >> "$report_file"

# =====================================================
# Kubernetes Health
# =====================================================

not_ready_nodes=$(kubectl get nodes \
--no-headers 2>/dev/null | \
grep -vc Ready)

{
echo "===== KUBERNETES ====="
echo "Not Ready Nodes : $not_ready_nodes"
echo
} >> "$report_file"

if [ "$not_ready_nodes" -gt 0 ]
then
    platform_score=$((platform_score-15))
fi

# =====================================================
# Jenkins Health
# =====================================================

jenkins_url="http://jenkins.company.com"

jenkins_status=$(curl -s \
-o /dev/null \
-w "%{http_code}" \
"$jenkins_url/login")

{
echo "===== CI/CD ====="
echo "Jenkins Status Code : $jenkins_status"
echo
} >> "$report_file"

if [ "$jenkins_status" != "200" ]
then
    platform_score=$((platform_score-15))
fi

# =====================================================
# Database Health
# =====================================================

mysqladmin ping \
>/dev/null 2>&1

if [ $? -eq 0 ]
then
    db_status="HEALTHY"
else
    db_status="UNHEALTHY"

    platform_score=$((platform_score-20))
fi

{
echo "===== DATABASE ====="
echo "Database Status : $db_status"
echo
} >> "$report_file"

# =====================================================
# Platform Assessment
# =====================================================

if [ "$platform_score" -ge 85 ]
then
    platform_status="HEALTHY"
elif [ "$platform_score" -ge 60 ]
then
    platform_status="WARNING"
else
    platform_status="CRITICAL"
fi

# =====================================================
# Executive Summary
# =====================================================

{
echo "========================================="
echo " EXECUTIVE SUMMARY"
echo "========================================="
echo "Platform Score  : $platform_score"
echo "Platform Status : $platform_status"
echo
echo "Recommendation:"
} >> "$report_file"

if [ "$platform_status" = "HEALTHY" ]
then

    echo "Platform operating normally." \
    >> "$report_file"

elif [ "$platform_status" = "WARNING" ]
then

    echo "Review platform risks." \
    >> "$report_file"

else

    echo "Immediate engineering action required." \
    >> "$report_file"

fi

# =====================================================
# Completion
# =====================================================

echo
echo "Platform Engineering Framework Complete"
echo "Report Generated:"
echo "$report_file"

echo "Platform Status: $platform_status"