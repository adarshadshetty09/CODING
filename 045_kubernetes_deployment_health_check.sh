#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor Kubernetes
deployment health.

What this script does:
1. Retrieves deployments
2. Checks desired replicas
3. Checks available replicas
4. Identifies unhealthy deployments
5. Generates health report
=========================================================
COMMENT

namespace="default"

echo "=================================================="
echo " KUBERNETES DEPLOYMENT HEALTH REPORT"
echo "=================================================="

kubectl get deployments -n "$namespace" --no-headers | \
while read deployment ready up_to_date available age
do
    desired=$(echo "$ready" | cut -d'/' -f2)
    current=$(echo "$ready" | cut -d'/' -f1)

    if [ "$desired" -eq "$current" ]
    then
        echo "✅ $deployment : Healthy ($ready)"
    else
        echo "❌ $deployment : Unhealthy ($ready)"
    fi
done