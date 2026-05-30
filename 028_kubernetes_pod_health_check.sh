#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor Kubernetes
pods and identify unhealthy pods.

What this script does:
1. Checks all pods in a namespace
2. Identifies unhealthy pods
3. Displays pod name, readiness and status
4. Counts healthy and unhealthy pods
5. Generates a pod health report
=========================================================
COMMENT

# Namespace
namespace="default"

healthy_count=0
unhealthy_count=0

echo "================================="
echo " KUBERNETES POD HEALTH REPORT"
echo "================================="
echo "Namespace: $namespace"
echo ""

kubectl get pods -n "$namespace" --no-headers | while read pod ready status rest
do
    if [ "$status" = "Running" ]
    then
        echo "✅ $pod | Ready: $ready | Status: $status"
    else
        echo "❌ $pod | Ready: $ready | Status: $status"
    fi
done

echo ""
echo "================================="
echo "UNHEALTHY POD SUMMARY"
echo "================================="

kubectl get pods -n "$namespace" --no-headers | while read pod ready status rest
do
    if [ "$status" != "Running" ]
    then
        echo "Pod Name : $pod"
        echo "Ready    : $ready"
        echo "Status   : $status"
        echo "---------------------------------"
    fi
done