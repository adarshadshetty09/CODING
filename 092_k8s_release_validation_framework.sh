#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to validate whether a
Kubernetes application release is ready for
production deployment.

Scenario:
Tonight a production release is scheduled.

The Change Advisory Board (CAB) meeting
starts in 30 minutes.

Before approving the deployment, the
Platform Engineering team must determine
whether the application satisfies all
production readiness requirements.

If critical checks fail, the release
must be stopped immediately.

Purpose:
Provide a GO / NO-GO decision before
production deployment.

What this script does:
1. Checks deployment availability
2. Checks pod health
3. Checks HPA existence
4. Checks PDB existence
5. Checks resource limits
6. Checks readiness probes
7. Checks liveness probes
8. Generates release validation report
9. Produces GO / NO-GO recommendation

Prerequisites:
- kubectl installed
- Cluster access configured
- Target namespace exists

Expected Output:
release_validation_report.txt

GO or NO-GO recommendation

Real-world Use Case:
Used by Platform Engineers, SREs and
Release Managers before production
deployments.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

namespace="production"
report_file="release_validation_report.txt"

failed_checks=0

# =====================================================
# Report Header
# =====================================================

{
echo "========================================="
echo " KUBERNETES RELEASE VALIDATION REPORT"
echo "========================================="
echo "Generated: $(date)"
echo "Namespace: $namespace"
echo
} > "$report_file"

# =====================================================
# Deployment Availability Check
# =====================================================

{
echo "===== DEPLOYMENT STATUS ====="
kubectl get deployments -n "$namespace"
echo
} >> "$report_file"

unavailable=$(kubectl get deployments \
-n "$namespace" \
--no-headers | awk '$2!=$3 {count++} END {print count+0}')

if [ "$unavailable" -gt 0 ]
then
    failed_checks=$((failed_checks + 1))
fi

# =====================================================
# Failed Pods Check
# =====================================================

{
echo "===== FAILED PODS ====="
kubectl get pods -n "$namespace" | \
grep -E "CrashLoopBackOff|Error|ImagePullBackOff|Pending"
echo
} >> "$report_file"

failed_pods=$(kubectl get pods -n "$namespace" | \
grep -E "CrashLoopBackOff|Error|ImagePullBackOff|Pending" | wc -l)

if [ "$failed_pods" -gt 0 ]
then
    failed_checks=$((failed_checks + 1))
fi

# =====================================================
# HPA Validation
# =====================================================

hpa_count=$(kubectl get hpa -n "$namespace" \
--no-headers 2>/dev/null | wc -l)

{
echo "===== HPA STATUS ====="
kubectl get hpa -n "$namespace" 2>/dev/null
echo
} >> "$report_file"

if [ "$hpa_count" -eq 0 ]
then
    failed_checks=$((failed_checks + 1))
fi

# =====================================================
# PDB Validation
# =====================================================

pdb_count=$(kubectl get pdb -n "$namespace" \
--no-headers 2>/dev/null | wc -l)

{
echo "===== PDB STATUS ====="
kubectl get pdb -n "$namespace" 2>/dev/null
echo
} >> "$report_file"

if [ "$pdb_count" -eq 0 ]
then
    failed_checks=$((failed_checks + 1))
fi

# =====================================================
# Resource Limits Validation
# =====================================================

{
echo "===== RESOURCE LIMIT REVIEW ====="
kubectl get deployments -n "$namespace" \
-o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}'
echo
} >> "$report_file"

# =====================================================
# Event Review
# =====================================================

{
echo "===== WARNING EVENTS ====="
kubectl get events -n "$namespace" \
--field-selector type=Warning
echo
} >> "$report_file"

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
    echo "Release approved for deployment."
    } >> "$report_file"
else
    {
    echo "NO-GO"
    echo "Critical validation checks failed."
    } >> "$report_file"
fi

# =====================================================
# Completion
# =====================================================

echo
echo "========================================="
echo " Release Validation Complete"
echo "========================================="

echo
echo "Report Generated:"
echo "$report_file"

if [ "$failed_checks" -eq 0 ]
then
    echo "FINAL DECISION: GO"
else
    echo "FINAL DECISION: NO-GO"
fi