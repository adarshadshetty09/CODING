#!/bin/bash

<<COMMENT
=========================================================
Question:
Monitor Kubernetes nodes and report
unhealthy nodes.

What this script does:
1. Checks all nodes
2. Displays healthy nodes
3. Displays unhealthy node summary
=========================================================
COMMENT

echo "================================="
echo " KUBERNETES NODE HEALTH REPORT"
echo "================================="

healthy=0
unhealthy=0

kubectl get nodes --no-headers | while read node status roles age version
do
    if [ "$status" = "Ready" ]
    then
        echo "✅ $node : Ready"
    else
        echo "❌ $node : $status"
    fi
done

echo ""
echo "To investigate a node:"

echo "kubectl describe node <node-name>"