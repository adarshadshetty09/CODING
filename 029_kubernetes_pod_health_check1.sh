#!/bin/bash

<<COMMENT
=========================================================
Question:
Monitor Kubernetes pods across multiple
namespaces and identify unhealthy pods.

What this script does:
1. Checks multiple namespaces
2. Identifies unhealthy pods
3. Displays pod health report
=========================================================
COMMENT

namespaces=("default" "kube-system" "monitoring")

for ns in "${namespaces[@]}"
do
    echo ""
    echo "================================="
    echo "Namespace: $ns"
    echo "================================="

    kubectl get pods -n "$ns" --no-headers | while read pod ready status rest
    do
        if [ "$status" = "Running" ]
        then
            echo "✅ $pod : Running"
        else
            echo "❌ $pod : $status"
        fi
    done
done