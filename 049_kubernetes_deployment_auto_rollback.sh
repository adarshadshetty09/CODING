#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor Kubernetes
deployment rollout and automatically
rollback on failure.

What this script does:
1. Checks deployment rollout status
2. Detects failed deployments
3. Performs automatic rollback
4. Displays recovery report
=========================================================
COMMENT

namespace="default"
deployment="nginx-deployment"

echo "=================================================="
echo " KUBERNETES DEPLOYMENT ROLLBACK REPORT"
echo "=================================================="

if kubectl rollout status deployment "$deployment" \
-n "$namespace" --timeout=60s
then
    echo ""
    echo "Deployment rollout successful"
else
    echo ""
    echo "Deployment rollout failed"
    echo "Initiating rollback..."

    kubectl rollout undo deployment "$deployment" \
    -n "$namespace"

    echo "Rollback completed"
fi