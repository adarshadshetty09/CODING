#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to audit Kubernetes
cluster cost optimization opportunities.

Purpose:
Identify unused and overprovisioned
resources that increase cloud costs.

What this script does:
1. Finds idle namespaces
2. Finds unused PVCs
3. Finds old ReplicaSets
4. Finds underutilized nodes
5. Finds excessive resource requests
6. Generates cost optimization report

Prerequisites:
- kubectl configured
- metrics-server installed

Expected Output:
Resource,Issue,Estimated Savings

Real-world Use Case:
Used by Platform Engineering, SRE and
FinOps teams for cloud cost optimization.

=========================================================
COMMENT

report_file="cost_optimization_report.csv"

echo "Resource,Issue,Estimated_Savings" \
> "$report_file"

# =====================================================
# Idle Namespaces
# =====================================================

kubectl get ns --no-headers | awk '{print $1}' | while read ns
do
    pod_count=$(kubectl get pods -n "$ns" \
    --no-headers 2>/dev/null | wc -l)

    if [ "$pod_count" -eq 0 ]
    then
        echo "Namespace:$ns,Idle Namespace,Review/Delete" \
        >> "$report_file"
    fi
done

# =====================================================
# Unused PVCs
# =====================================================

kubectl get pvc -A --no-headers | while read ns pvc status rest
do
    if [ "$status" != "Bound" ]
    then
        echo "PVC:$pvc,Unused PVC,Storage Savings" \
        >> "$report_file"
    fi
done

# =====================================================
# Old ReplicaSets
# =====================================================

kubectl get rs -A --no-headers | while read ns rs desired current ready age
do
    if [ "$desired" -eq 0 ]
    then
        echo "ReplicaSet:$rs,Unused ReplicaSet,Cleanup Candidate" \
        >> "$report_file"
    fi
done

# =====================================================
# Underutilized Nodes
# =====================================================

kubectl top nodes --no-headers 2>/dev/null | \
while read node cpu memory rest
do
    cpu_usage=$(echo "$cpu" | sed 's/m//')

    if [ "$cpu_usage" -lt 100 ]
    then
        echo "Node:$node,Underutilized Node,Consider Consolidation" \
        >> "$report_file"
    fi
done

# =====================================================
# Large Resource Requests
# =====================================================

kubectl get deployments -A --no-headers | \
while read ns deploy ready uptodate available age
do
    cpu_request=$(kubectl get deployment "$deploy" \
    -n "$ns" \
    -o jsonpath='{.spec.template.spec.containers[0].resources.requests.cpu}')

    if echo "$cpu_request" | grep -q "^[5-9]$"
    then
        echo "Deployment:$deploy,Large CPU Request,Review Sizing" \
        >> "$report_file"
    fi
done

echo
echo "Cost Optimization Audit Complete"
echo "Report Generated:"
echo "$report_file"