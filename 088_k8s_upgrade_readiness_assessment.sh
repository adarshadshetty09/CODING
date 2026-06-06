#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to assess Kubernetes
cluster upgrade readiness.

Scenario:
The organization plans to upgrade the
Kubernetes cluster from version 1.30
to 1.31.

Before upgrading, Platform Engineering
must identify workloads that may break
after the upgrade due to deprecated APIs,
unsupported resources, or outdated
configurations.

Purpose:
Reduce upgrade risk and prevent production
outages during cluster upgrades.

What this script does:
1. Scans cluster resources
2. Detects deprecated API versions
3. Detects PodSecurityPolicy usage
4. Detects old Ingress API versions
5. Detects unsupported workloads
6. Generates upgrade readiness report

Prerequisites:
- kubectl installed
- Cluster access configured

Expected Output:
Resource,Issue,Risk

Real-world Use Case:
Used by Kubernetes Administrators,
Platform Engineers and SRE teams before
production cluster upgrades.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

report_file="upgrade_readiness_report.csv"

echo "Resource,Issue,Risk" > "$report_file"

# =====================================================
# Check PodSecurityPolicy
# PSP was removed in Kubernetes 1.25
# =====================================================

echo "Checking PodSecurityPolicies..."

psp_count=$(kubectl get psp --no-headers 2>/dev/null | wc -l)

if [ "$psp_count" -gt 0 ]
then
    echo "PodSecurityPolicy,Deprecated Resource,CRITICAL" \
    >> "$report_file"
fi

# =====================================================
# Check Deprecated Ingress APIs
# =====================================================

echo "Checking Ingress API versions..."

kubectl get ingress -A -o yaml 2>/dev/null | \
grep "extensions/v1beta1" >/dev/null

if [ $? -eq 0 ]
then
    echo "Ingress,extensions/v1beta1 Deprecated,HIGH" \
    >> "$report_file"
fi

# =====================================================
# Check Deprecated CronJob APIs
# =====================================================

echo "Checking CronJobs..."

kubectl get cronjobs -A -o yaml 2>/dev/null | \
grep "batch/v1beta1" >/dev/null

if [ $? -eq 0 ]
then
    echo "CronJob,batch/v1beta1 Deprecated,HIGH" \
    >> "$report_file"
fi

# =====================================================
# Check Deprecated Deployments APIs
# =====================================================

echo "Checking Deployments..."

kubectl get deployments -A -o yaml 2>/dev/null | \
grep "extensions/v1beta1" >/dev/null

if [ $? -eq 0 ]
then
    echo "Deployment,extensions/v1beta1 Deprecated,CRITICAL" \
    >> "$report_file"
fi

# =====================================================
# Check Deprecated DaemonSet APIs
# =====================================================

echo "Checking DaemonSets..."

kubectl get daemonsets -A -o yaml 2>/dev/null | \
grep "extensions/v1beta1" >/dev/null

if [ $? -eq 0 ]
then
    echo "DaemonSet,extensions/v1beta1 Deprecated,HIGH" \
    >> "$report_file"
fi

# =====================================================
# Check Deprecated StatefulSet APIs
# =====================================================

echo "Checking StatefulSets..."

kubectl get statefulsets -A -o yaml 2>/dev/null | \
grep "apps/v1beta1" >/dev/null

if [ $? -eq 0 ]
then
    echo "StatefulSet,apps/v1beta1 Deprecated,HIGH" \
    >> "$report_file"
fi

# =====================================================
# Summary
# =====================================================

echo
echo "========================================"
echo " Upgrade Readiness Assessment Complete"
echo "========================================"

echo
echo "Report Generated:"
echo "$report_file"

echo
cat "$report_file"