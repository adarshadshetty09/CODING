#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to collect Kubernetes
incident evidence for a postmortem analysis.

Scenario:
Yesterday a Sev-1 production outage
occurred that affected customer traffic.

The incident has been resolved, but
management and engineering leadership
require a postmortem.

The SRE team must gather evidence from
the cluster before logs and events expire.

The collected data will be used for:

- Root Cause Analysis (RCA)
- Incident Timeline
- Corrective Actions
- Preventive Actions

Purpose:
Automate collection of incident-related
data required for postmortem investigations.

What this script does:
1. Collects cluster information
2. Collects node status
3. Collects deployment status
4. Collects warning events
5. Collects pod restart information
6. Collects failed pods
7. Generates postmortem evidence report

Prerequisites:
- kubectl installed
- Cluster access configured
- Read access to all namespaces

Expected Output:
postmortem_report.txt

Real-world Use Case:
Used after Sev-1 and Sev-2 incidents
to gather evidence for postmortems,
RCA reviews and engineering audits.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

report_file="postmortem_report.txt"

# =====================================================
# Report Header
# =====================================================

{
echo "========================================="
echo " KUBERNETES POSTMORTEM DATA REPORT"
echo "========================================="
echo "Generated: $(date)"
echo
} > "$report_file"

# =====================================================
# Cluster Information
# =====================================================

{
echo "===== CLUSTER INFO ====="
kubectl cluster-info
echo
} >> "$report_file"

# =====================================================
# Node Status
# =====================================================

{
echo "===== NODE STATUS ====="
kubectl get nodes -o wide
echo
} >> "$report_file"

# =====================================================
# Deployment Status
# =====================================================

{
echo "===== DEPLOYMENT STATUS ====="
kubectl get deployments -A
echo
} >> "$report_file"

# =====================================================
# Failed Pods
# =====================================================

{
echo "===== FAILED PODS ====="
kubectl get pods -A | \
grep -E "CrashLoopBackOff|Error|ImagePullBackOff|Pending"
echo
} >> "$report_file"

# =====================================================
# High Restart Pods
# =====================================================

{
echo "===== HIGH RESTART PODS ====="
kubectl get pods -A --no-headers | \
awk '$5 > 5 {print}'
echo
} >> "$report_file"

# =====================================================
# Warning Events
# =====================================================

{
echo "===== WARNING EVENTS ====="
kubectl get events -A \
--field-selector type=Warning
echo
} >> "$report_file"

# =====================================================
# Recent ReplicaSets
# Useful for identifying deployments
# around the incident window
# =====================================================

{
echo "===== RECENT REPLICASETS ====="
kubectl get rs -A
echo
} >> "$report_file"

# =====================================================
# Resource Usage
# =====================================================

{
echo "===== NODE RESOURCE USAGE ====="
kubectl top nodes 2>/dev/null
echo

echo "===== POD RESOURCE USAGE ====="
kubectl top pods -A 2>/dev/null
echo
} >> "$report_file"

# =====================================================
# Completion
# =====================================================

echo
echo "========================================="
echo " Postmortem Data Collection Complete"
echo "========================================="

echo
echo "Report Generated:"
echo "$report_file"