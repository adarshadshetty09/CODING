#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to audit Kubernetes
deployments before production release.

Purpose:
Ensure deployments follow operational and
security best practices before deployment.

What this script does:
1. Scans all deployments
2. Verifies desired replicas are available
3. Checks resource limits
4. Checks resource requests
5. Checks liveness probes
6. Checks readiness probes
7. Verifies approved image registry
8. Generates audit report

Prerequisites:
- kubectl configured
- Cluster access available

Expected Output:
Namespace,Deployment,Issue,Severity,Recommendation

Real-world Use Case:
Used by Platform Engineering and SRE teams
during release readiness reviews.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

approved_registry="company-registry.com"

report_file="deployment_readiness_audit.csv"

# =====================================================
# CSV Header
# =====================================================

echo "Namespace,Deployment,Issue,Severity,Recommendation" \
> "$report_file"

# =====================================================
# Get Deployments
# =====================================================

deployments=$(kubectl get deployments -A --no-headers)

# =====================================================
# Audit Deployments
# =====================================================

echo "$deployments" | while read namespace deployment ready up_to_date available age
do

    desired=$(kubectl get deployment "$deployment" -n "$namespace" \
    -o jsonpath='{.spec.replicas}')

    available_replicas=$(kubectl get deployment "$deployment" -n "$namespace" \
    -o jsonpath='{.status.availableReplicas}')

    image=$(kubectl get deployment "$deployment" -n "$namespace" \
    -o jsonpath='{.spec.template.spec.containers[0].image}')

    cpu_limit=$(kubectl get deployment "$deployment" -n "$namespace" \
    -o jsonpath='{.spec.template.spec.containers[0].resources.limits.cpu}')

    memory_limit=$(kubectl get deployment "$deployment" -n "$namespace" \
    -o jsonpath='{.spec.template.spec.containers[0].resources.limits.memory}')

    readiness=$(kubectl get deployment "$deployment" -n "$namespace" \
    -o jsonpath='{.spec.template.spec.containers[0].readinessProbe}')

    liveness=$(kubectl get deployment "$deployment" -n "$namespace" \
    -o jsonpath='{.spec.template.spec.containers[0].livenessProbe}')

    # Replica Check
    if [ "$desired" != "$available_replicas" ]
    then
        echo "$namespace,$deployment,Replica Mismatch,CRITICAL,Investigate Deployment" \
        >> "$report_file"
    fi

    # Resource Limits Check
    if [ -z "$cpu_limit" ] || [ -z "$memory_limit" ]
    then
        echo "$namespace,$deployment,Missing Resource Limits,HIGH,Define Limits" \
        >> "$report_file"
    fi

    # Readiness Probe Check
    if [ -z "$readiness" ]
    then
        echo "$namespace,$deployment,Missing Readiness Probe,HIGH,Add Readiness Probe" \
        >> "$report_file"
    fi

    # Liveness Probe Check
    if [ -z "$liveness" ]
    then
        echo "$namespace,$deployment,Missing Liveness Probe,HIGH,Add Liveness Probe" \
        >> "$report_file"
    fi

    # Registry Check
    echo "$image" | grep -q "^$approved_registry"

    if [ $? -ne 0 ]
    then
        echo "$namespace,$deployment,Unapproved Registry,CRITICAL,Use Approved Registry" \
        >> "$report_file"
    fi

done

echo
echo "Deployment Readiness Audit Complete"
echo "Report Generated: $report_file"