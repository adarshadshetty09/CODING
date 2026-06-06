#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to generate a Kubernetes
cluster capacity report.

Purpose:
Help SRE and Platform teams understand
cluster resource utilization and remaining
capacity.

What this script does:
1. Collects node CPU capacity
2. Collects node Memory capacity
3. Collects allocatable resources
4. Displays node readiness
5. Generates capacity report

Prerequisites:
- kubectl installed
- Metrics server recommended

Expected Output:
Node Name
CPU Capacity
Memory Capacity
CPU Allocatable
Memory Allocatable
Status

Real-world Use Case:
Used for cluster capacity planning and
infrastructure scaling decisions.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

report_file="cluster_capacity_report.csv"

# =====================================================
# CSV Header
# =====================================================

echo "Node,CPU_Capacity,CPU_Allocatable,Memory_Capacity,Memory_Allocatable,Status" \
> "$report_file"

# =====================================================
# Get Nodes
# =====================================================

nodes=$(kubectl get nodes --no-headers | awk '{print $1}')

# =====================================================
# Process Nodes
# =====================================================

for node in $nodes
do
    echo "Analyzing $node..."

    cpu_capacity=$(kubectl get node "$node" \
    -o jsonpath='{.status.capacity.cpu}')

    cpu_allocatable=$(kubectl get node "$node" \
    -o jsonpath='{.status.allocatable.cpu}')

    mem_capacity=$(kubectl get node "$node" \
    -o jsonpath='{.status.capacity.memory}')

    mem_allocatable=$(kubectl get node "$node" \
    -o jsonpath='{.status.allocatable.memory}')

    status=$(kubectl get node "$node" \
    --no-headers | awk '{print $2}')

    echo "$node,$cpu_capacity,$cpu_allocatable,$mem_capacity,$mem_allocatable,$status" \
    >> "$report_file"

done

# =====================================================
# Completion
# =====================================================

echo
echo "Cluster Capacity Report Generated"
echo "$report_file"