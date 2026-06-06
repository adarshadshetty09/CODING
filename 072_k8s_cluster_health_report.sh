#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to generate a daily
Kubernetes Cluster Health Report.

What this script does:
1. Checks Node Health
2. Checks Pod Health
3. Checks Deployment Health
4. Checks Failed Pods
5. Checks High Restart Pods
6. Displays Cluster Resource Usage
7. Generates Health Dashboard
=========================================================
COMMENT

namespace="default"
restart_threshold=5

echo "========================================================="
echo "          KUBERNETES CLUSTER HEALTH REPORT"
echo "========================================================="
echo "Date : $(date)"
echo ""

#########################################################
# Node Health
#########################################################

echo "================ NODE STATUS ================="

kubectl get nodes

echo ""

#########################################################
# Deployment Health
#########################################################

echo "============= DEPLOYMENT STATUS =============="

kubectl get deployments -A

echo ""

#########################################################
# Failed Pods
#########################################################

echo "=============== FAILED PODS =================="

failed_pods=$(kubectl get pods -A --no-headers | \
awk '$4!="Running" {print}')

if [ -z "$failed_pods" ]
then
    echo "No Failed Pods Found"
else
    echo "$failed_pods"
fi

echo ""

#########################################################
# Pod Restart Report
#########################################################

echo "============= HIGH RESTART PODS =============="

kubectl get pods -A --no-headers | \
while read ns pod ready status restarts age
do
    if [ "$restarts" -gt "$restart_threshold" ]
    then
        echo "$ns | $pod | Restarts=$restarts"
    fi
done

echo ""

#########################################################
# Node Resource Usage
#########################################################

echo "============== NODE RESOURCE USAGE ==========="

kubectl top nodes 2>/dev/null

echo ""

#########################################################
# Pod Resource Usage
#########################################################

echo "=============== TOP POD USAGE ================"

kubectl top pods -A \
--sort-by=memory 2>/dev/null | head -10

echo ""

#########################################################
# Cluster Summary
#########################################################

echo "================ CLUSTER SUMMARY ============="

node_count=$(kubectl get nodes --no-headers | wc -l)

pod_count=$(kubectl get pods -A --no-headers | wc -l)

deployment_count=$(kubectl get deployments -A --no-headers | wc -l)

echo "Total Nodes       : $node_count"
echo "Total Pods        : $pod_count"
echo "Total Deployments : $deployment_count"

echo ""
echo "========================================================="
echo "REPORT GENERATED SUCCESSFULLY"
echo "========================================================="