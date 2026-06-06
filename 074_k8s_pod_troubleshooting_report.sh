#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to troubleshoot
a Kubernetes pod automatically.

What this script does:
1. Checks pod status
2. Checks restart count
3. Retrieves pod events
4. Retrieves recent logs
5. Displays node placement
6. Generates troubleshooting report
=========================================================
COMMENT

namespace="default"
pod_name="$1"

if [ -z "$pod_name" ]
then
    echo "Usage: $0 <pod-name>"
    exit 1
fi

echo "================================================="
echo " KUBERNETES POD TROUBLESHOOTING REPORT"
echo "================================================="

echo ""
echo "Pod Status"
echo "-------------------------------------------------"

kubectl get pod "$pod_name" -n "$namespace" -o wide

echo ""
echo "Pod Description"
echo "-------------------------------------------------"

kubectl describe pod "$pod_name" -n "$namespace"

echo ""
echo "Recent Logs"
echo "-------------------------------------------------"

kubectl logs "$pod_name" -n "$namespace" --tail=50

echo ""
echo "Previous Logs (if restarted)"
echo "-------------------------------------------------"

kubectl logs "$pod_name" -n "$namespace" --previous 2>/dev/null

echo ""
echo "================================================="
echo " TROUBLESHOOTING COMPLETED"
echo "================================================="