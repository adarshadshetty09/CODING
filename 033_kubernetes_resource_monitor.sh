#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor Kubernetes
pod CPU and Memory usage.

What this script does:
1. Retrieves pod resource usage
2. Displays CPU and Memory consumption
3. Identifies resource-heavy pods
4. Helps troubleshoot performance issues
=========================================================
COMMENT

namespace="default"

echo "================================="
echo " KUBERNETES RESOURCE REPORT"
echo "================================="

minikube kubectl -- top pods -n "$namespace"