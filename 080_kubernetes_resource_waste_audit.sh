#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to audit Kubernetes
resource requests and limits.

Purpose:
Identify pods that do not follow resource
management best practices.

What this script does:
1. Scans all namespaces
2. Finds pods without CPU requests
3. Finds pods without Memory requests
4. Finds pods without CPU limits
5. Finds pods without Memory limits
6. Generates audit report

Prerequisites:
- kubectl installed
- Cluster access configured

Expected Output:
Namespace,Pod,Issue,Recommendation

Real-world Use Case:
Used by Platform Engineering teams to
reduce Kubernetes resource waste and
improve cluster efficiency.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

report_file="resource_waste_audit.csv"

# =====================================================
# CSV Header
# =====================================================

echo "Namespace,Pod,Issue,Recommendation" \
> "$report_file"

# =====================================================
# Get All Pods
# =====================================================

pods=$(kubectl get pods -A --no-headers)

# =====================================================
# Process Pods
# =====================================================

echo "$pods" | while read namespace pod rest
do

    cpu_request=$(kubectl get pod "$pod" -n "$namespace" \
    -o jsonpath='{.spec.containers[*].resources.requests.cpu}')

    mem_request=$(kubectl get pod "$pod" -n "$namespace" \
    -o jsonpath='{.spec.containers[*].resources.requests.memory}')

    cpu_limit=$(kubectl get pod "$pod" -n "$namespace" \
    -o jsonpath='{.spec.containers[*].resources.limits.cpu}')

    mem_limit=$(kubectl get pod "$pod" -n "$namespace" \
    -o jsonpath='{.spec.containers[*].resources.limits.memory}')

    if [ -z "$cpu_request" ]
    then
        echo "$namespace,$pod,Missing CPU Request,Add CPU Request" \
        >> "$report_file"
    fi

    if [ -z "$mem_request" ]
    then
        echo "$namespace,$pod,Missing Memory Request,Add Memory Request" \
        >> "$report_file"
    fi

    if [ -z "$cpu_limit" ]
    then
        echo "$namespace,$pod,Missing CPU Limit,Add CPU Limit" \
        >> "$report_file"
    fi

    if [ -z "$mem_limit" ]
    then
        echo "$namespace,$pod,Missing Memory Limit,Add Memory Limit" \
        >> "$report_file"
    fi

done

echo
echo "Audit Complete"
echo "Report Generated: $report_file"