#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to automatically
recover failed Kubernetes pods.

What this script does:
1. Checks pod status
2. Detects failed pods
3. Deletes failed pods
4. Allows Kubernetes to recreate them
5. Implements self-healing automation
=========================================================
COMMENT

namespace="default"

echo "=================================================="
echo " KUBERNETES POD AUTO RECOVERY REPORT"
echo "=================================================="

kubectl get pods -n "$namespace" --no-headers | \
while read pod ready status rest
do
    if [[ "$status" == "CrashLoopBackOff" || \
          "$status" == "Error" || \
          "$status" == "ImagePullBackOff" || \
          "$status" == "ErrImagePull" ]]
    then
        echo "Failed Pod Detected: $pod"
        echo "Status: $status"

        echo "Deleting pod..."

        kubectl delete pod "$pod" -n "$namespace"

        echo "Recovery triggered."
        echo "----------------------------------"
    fi
done