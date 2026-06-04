#!/bin/bash

namespace="default"
threshold=5

echo "=================================================="
echo " KUBERNETES POD RESTART REPORT"
echo "=================================================="

printf "%-40s %-10s %-15s\n" \
"POD NAME" "RESTARTS" "STATUS"

echo "--------------------------------------------------"

kubectl get pods -n "$namespace" --no-headers | \
while read pod ready status restarts age
do
    printf "%-40s %-10s %-15s\n" \
    "$pod" "$restarts" "$status"

    if [ "$restarts" -gt "$threshold" ]
    then
        echo "⚠️  High restart count detected!"
    fi
done