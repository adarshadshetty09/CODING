#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to validate whether a
Kubernetes application can be deployed with
zero downtime.

Scenario:
Black Friday sale is currently running.

The e-commerce platform processes thousands
of customer orders every minute.

A new application release must be deployed
during business hours.

Management has clearly stated:

"Customers must not experience any downtime."

Before deployment, the Platform Engineering
team must verify that the application
supports a zero-downtime deployment.

Purpose:
Validate deployment readiness for
customer-facing production workloads.

What this script does:
1. Checks replica count
2. Checks RollingUpdate strategy
3. Checks Pod Disruption Budget (PDB)
4. Checks readiness probes
5. Checks HPA configuration
6. Checks service endpoints
7. Generates zero-downtime validation report
8. Provides GO / NO-GO recommendation

Prerequisites:
- kubectl installed
- Cluster access configured

Expected Output:
zero_downtime_validation_report.txt

Deployment Status:
READY / NOT READY

Real-world Use Case:
Used by Platform Engineers, SREs and
Release Managers before deploying
critical customer-facing applications.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

namespace="production"
report_file="zero_downtime_validation_report.txt"

status=0

# =====================================================
# Report Header
# =====================================================

{
echo "========================================="
echo " ZERO DOWNTIME DEPLOYMENT VALIDATION"
echo "========================================="
echo "Generated: $(date)"
echo "Namespace: $namespace"
echo
} > "$report_file"

# =====================================================
# Deployment Checks
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
    # Replica Check
    # ===============================================

    replicas=$(kubectl get deployment "$deployment" \
    -n "$namespace" \
    -o jsonpath='{.spec.replicas}')

    if [ "$replicas" -ge 2 ]
    then
        echo "[PASS] Multiple Replicas Configured ($replicas)" \
        >> "$report_file"
    else
        echo "[FAIL] Single Replica Deployment" \
        >> "$report_file"
        status=1
    fi

    # ===============================================
    # RollingUpdate Strategy
    # ===============================================

    strategy=$(kubectl get deployment "$deployment" \
    -n "$namespace" \
    -o jsonpath='{.spec.strategy.type}')

    if [ "$strategy" = "RollingUpdate" ]
    then
        echo "[PASS] RollingUpdate Strategy" \
        >> "$report_file"
    else
        echo "[FAIL] Recreate Strategy Detected" \
        >> "$report_file"
        status=1
    fi

    # ===============================================
    # Readiness Probe
    # ===============================================

    readiness=$(kubectl get deployment "$deployment" \
    -n "$namespace" \
    -o jsonpath='{.spec.template.spec.containers[0].readinessProbe}')

    if [ -n "$readiness" ]
    then
        echo "[PASS] Readiness Probe Configured" \
        >> "$report_file"
    else
        echo "[FAIL] Missing Readiness Probe" \
        >> "$report_file"
        status=1
    fi

    # ===============================================
    # HPA Check
    # ===============================================

    kubectl get hpa -n "$namespace" \
    2>/dev/null | grep -q "$deployment"

    if [ $? -eq 0 ]
    then
        echo "[PASS] HPA Configured" \
        >> "$report_file"
    else
        echo "[FAIL] HPA Missing" \
        >> "$report_file"
    fi

    # ===============================================
    # PDB Check
    # ===============================================

    kubectl get pdb -n "$namespace" \
    2>/dev/null | grep -q "$deployment"

    if [ $? -eq 0 ]
    then
        echo "[PASS] PDB Configured" \
        >> "$report_file"
    else
        echo "[FAIL] PDB Missing" \
        >> "$report_file"
        status=1
    fi

done

# =====================================================
# Endpoint Validation
# =====================================================

{
echo
echo "===== SERVICE ENDPOINTS ====="
kubectl get endpoints -n "$namespace"
} >> "$report_file"

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
    echo "DEPLOYMENT STATUS : READY"
    echo "Zero-downtime deployment possible."
    } >> "$report_file"
else
    {
    echo "DEPLOYMENT STATUS : NOT READY"
    echo "Resolve validation failures first."
    } >> "$report_file"
fi

# =====================================================
# Completion
# =====================================================

echo
echo "Zero Downtime Validation Complete"
echo "Report Generated:"
echo "$report_file"

if [ "$status" -eq 0 ]
then
    echo "DEPLOYMENT STATUS : READY"
else
    echo "DEPLOYMENT STATUS : NOT READY"
fi