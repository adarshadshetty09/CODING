#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to verify Kubernetes
rollback readiness before a production
deployment.

Scenario:
A high-risk payment application release is
scheduled tonight.

The application handles customer payments
and any deployment failure could result in
revenue loss.

Management requires confirmation that a
rollback can be executed immediately if
the deployment causes service degradation.

The Platform Engineering team must verify:

- Rollout history exists
- Previous ReplicaSet exists
- Deployment strategy supports rolling updates
- Current deployment is healthy
- Rollback target is available

Purpose:
Ensure production rollback can be performed
quickly and safely during failed releases.

What this script does:
1. Checks deployment rollout history
2. Checks previous ReplicaSets
3. Verifies deployment strategy
4. Verifies deployment health
5. Generates rollback readiness report
6. Provides rollback recommendation

Prerequisites:
- kubectl installed
- Cluster access configured

Expected Output:
rollback_readiness_report.txt

Rollback Status:
READY / NOT READY

Real-world Use Case:
Used by DevOps Engineers, Platform
Engineers and SRE teams before
high-risk production deployments.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

namespace="production"
report_file="rollback_readiness_report.txt"

status=0

# =====================================================
# Report Header
# =====================================================

{
echo "========================================="
echo " KUBERNETES ROLLBACK READINESS REPORT"
echo "========================================="
echo "Generated: $(date)"
echo
} > "$report_file"

# =====================================================
# Process Deployments
# =====================================================

deployments=$(kubectl get deployments \
-n "$namespace" \
--no-headers | awk '{print $1}')

for deployment in $deployments
do

    {
    echo
    echo "=================================="
    echo "Deployment : $deployment"
    echo "=================================="
    } >> "$report_file"

    # ===============================================
    # Rollout History
    # ===============================================

    history=$(kubectl rollout history deployment/$deployment \
    -n "$namespace" 2>/dev/null)

    if [ -n "$history" ]
    then
        echo "[PASS] Rollout History Exists" \
        >> "$report_file"
    else
        echo "[FAIL] Rollout History Missing" \
        >> "$report_file"

        status=1
    fi

    # ===============================================
    # ReplicaSet Check
    # ===============================================

    rs_count=$(kubectl get rs \
    -n "$namespace" \
    --no-headers | grep "$deployment" | wc -l)

    if [ "$rs_count" -gt 1 ]
    then
        echo "[PASS] Previous ReplicaSet Available" \
        >> "$report_file"
    else
        echo "[FAIL] No Rollback ReplicaSet Found" \
        >> "$report_file"

        status=1
    fi

    # ===============================================
    # Deployment Strategy Check
    # ===============================================

    strategy=$(kubectl get deployment "$deployment" \
    -n "$namespace" \
    -o jsonpath='{.spec.strategy.type}')

    if [ "$strategy" = "RollingUpdate" ]
    then
        echo "[PASS] RollingUpdate Strategy" \
        >> "$report_file"
    else
        echo "[FAIL] Non RollingUpdate Strategy" \
        >> "$report_file"

        status=1
    fi

    # ===============================================
    # Deployment Health Check
    # ===============================================

    desired=$(kubectl get deployment "$deployment" \
    -n "$namespace" \
    -o jsonpath='{.spec.replicas}')

    available=$(kubectl get deployment "$deployment" \
    -n "$namespace" \
    -o jsonpath='{.status.availableReplicas}')

    if [ "$desired" = "$available" ]
    then
        echo "[PASS] Deployment Healthy" \
        >> "$report_file"
    else
        echo "[FAIL] Deployment Unhealthy" \
        >> "$report_file"

        status=1
    fi

done

# =====================================================
# Final Decision
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
    echo "ROLLBACK STATUS : READY"
    echo "Rollback can be executed safely."
    } >> "$report_file"
else
    {
    echo "ROLLBACK STATUS : NOT READY"
    echo "Fix issues before deployment."
    } >> "$report_file"
fi

# =====================================================
# Completion
# =====================================================

echo
echo "Rollback Readiness Assessment Complete"
echo "Report Generated:"
echo "$report_file"

echo
if [ "$status" -eq 0 ]
then
    echo "ROLLBACK STATUS : READY"
else
    echo "ROLLBACK STATUS : NOT READY"
fi