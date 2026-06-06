#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to analyze the impact
of a Kubernetes node failure.

Scenario:
03:20 AM

Monitoring alerts indicate that node
worker-node-03 has become NotReady.

Several applications are running on this
node and management wants to know the
business impact immediately.

The SRE team must identify affected pods,
deployments and namespaces to prioritize
recovery efforts.

Purpose:
Help engineers quickly determine the scope
of impact during node failures and reduce
incident response time.

What this script does:
1. Detects NotReady nodes
2. Finds affected pods
3. Identifies impacted namespaces
4. Identifies impacted deployments
5. Generates impact analysis report
6. Helps estimate business impact

Prerequisites:
- kubectl installed
- Cluster access configured

Expected Output:
Node,Namespace,Pod,Deployment,Impact

Real-world Use Case:
Used by SRE and Platform Engineering teams
during infrastructure outages and node
failure incidents.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

report_file="node_failure_impact_report.csv"

echo "Node,Namespace,Pod,Deployment,Impact" \
> "$report_file"

# =====================================================
# Find NotReady Nodes
# =====================================================

echo "Checking cluster nodes..."

not_ready_nodes=$(kubectl get nodes \
--no-headers | awk '$2 != "Ready" {print $1}')

# =====================================================
# Exit if no failed nodes
# =====================================================

if [ -z "$not_ready_nodes" ]
then
    echo "No NotReady nodes found."
    exit 0
fi

# =====================================================
# Analyze Failed Nodes
# =====================================================

for node in $not_ready_nodes
do
    echo "Analyzing node: $node"

    kubectl get pods -A -o wide --no-headers | \
    awk -v node="$node" '$8==node' | \
    while read ns pod ready status rest
    do

        deployment=$(kubectl get pod "$pod" \
        -n "$ns" \
        -o jsonpath='{.metadata.ownerReferences[0].name}' \
        2>/dev/null)

        echo "$node,$ns,$pod,$deployment,HIGH" \
        >> "$report_file"

    done

done

# =====================================================
# Report Summary
# =====================================================

echo
echo "========================================"
echo " Node Failure Impact Analysis Complete"
echo "========================================"

echo
echo "Report Generated:"
echo "$report_file"

echo
cat "$report_file"