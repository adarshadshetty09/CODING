#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to generate a
Kubernetes namespace resource report.

What this script does:
1. Lists all namespaces
2. Counts pods per namespace
3. Counts deployments per namespace
4. Counts services per namespace
5. Generates a resource usage report
=========================================================
COMMENT

echo "==============================================="
echo " KUBERNETES NAMESPACE RESOURCE REPORT"
echo "==============================================="

printf "%-20s %-10s %-15s %-10s\n" \
"Namespace" "Pods" "Deployments" "Services"

echo "------------------------------------------------"

for ns in $(kubectl get ns --no-headers -o custom-columns=":metadata.name")
do
    pods=$(kubectl get pods -n "$ns" --no-headers 2>/dev/null | wc -l)

    deployments=$(kubectl get deployments -n "$ns" --no-headers 2>/dev/null | wc -l)

    services=$(kubectl get svc -n "$ns" --no-headers 2>/dev/null | wc -l)

    printf "%-20s %-10s %-15s %-10s\n" \
    "$ns" "$pods" "$deployments" "$services"
done