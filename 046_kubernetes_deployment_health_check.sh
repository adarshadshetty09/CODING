#!/bin/bash

namespace="default"

healthy=0
unhealthy=0

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

echo ""
echo "To investigate:"
echo "kubectl describe deployment <deployment-name>"