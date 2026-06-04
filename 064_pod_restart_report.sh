#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to identify Kubernetes
pods with high restart counts.

What this script does:
1. Retrieves pod restart counts
2. Compares against threshold
3. Identifies unstable pods
4. Generates restart report
5. Helps troubleshoot application issues
=========================================================
COMMENT

namespace="default"
threshold=5

echo "=================================================="
echo " KUBERNETES POD RESTART REPORT"
echo "=================================================="

kubectl get pods -n "$namespace" --no-headers | \
while read pod ready status restarts age
do
    if [ "$restarts" -gt "$threshold" ]
    then
        echo "⚠️  Pod: $pod"
        echo "    Restarts: $restarts"
        echo "    Status: $status"
        echo "--------------------------------------------------"
    fi
done