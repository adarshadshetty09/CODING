#!/bin/bash

echo "================================="
echo " KUBERNETES NODE HEALTH REPORT"
echo "================================="

healthy=0
unhealthy=0

while read node status roles age version
do
    if [ "$status" = "Ready" ]
    then
        echo "✅ $node : Ready"
        ((healthy++))
    else
        echo "❌ $node : $status"
        ((unhealthy++))
    fi
done < <(minikube kubectl -- get nodes --no-headers)

echo
echo "Healthy Nodes   : $healthy"
echo "Unhealthy Nodes : $unhealthy"
