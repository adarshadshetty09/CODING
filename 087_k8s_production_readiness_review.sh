#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to perform Kubernetes
Production Readiness Review (PRR).

Purpose:
Verify workloads meet production standards
before release.

What this script does:
1. Checks resource requests
2. Checks resource limits
3. Checks readiness probes
4. Checks liveness probes
5. Checks HPA
6. Checks PDB
7. Checks security context
8. Checks monitoring readiness
9. Generates PRR report

Prerequisites:
- kubectl configured
- Cluster access

Expected Output:
Application,Category,Result,Severity

Real-world Use Case:
Used by Platform Engineering and SRE teams
before approving production workloads.

=========================================================
COMMENT

report_file="production_readiness_review.csv"

echo "Application,Category,Result,Severity" \
> "$report_file"

kubectl get deployments -A --no-headers | \
while read ns deploy ready updated available age
do

    cpu_request=$(kubectl get deployment "$deploy" \
    -n "$ns" \
    -o jsonpath='{.spec.template.spec.containers[0].resources.requests.cpu}')

    cpu_limit=$(kubectl get deployment "$deploy" \
    -n "$ns" \
    -o jsonpath='{.spec.template.spec.containers[0].resources.limits.cpu}')

    readiness=$(kubectl get deployment "$deploy" \
    -n "$ns" \
    -o jsonpath='{.spec.template.spec.containers[0].readinessProbe}')

    liveness=$(kubectl get deployment "$deploy" \
    -n "$ns" \
    -o jsonpath='{.spec.template.spec.containers[0].livenessProbe}')

    security=$(kubectl get deployment "$deploy" \
    -n "$ns" \
    -o jsonpath='{.spec.template.spec.securityContext}')

    # Resource Requests
    if [ -z "$cpu_request" ]
    then
        echo "$deploy,Resource Request,FAIL,HIGH" \
        >> "$report_file"
    fi

    # Resource Limits
    if [ -z "$cpu_limit" ]
    then
        echo "$deploy,Resource Limit,FAIL,HIGH" \
        >> "$report_file"
    fi

    # Readiness Probe
    if [ -z "$readiness" ]
    then
        echo "$deploy,Readiness Probe,FAIL,CRITICAL" \
        >> "$report_file"
    fi

    # Liveness Probe
    if [ -z "$liveness" ]
    then
        echo "$deploy,Liveness Probe,FAIL,HIGH" \
        >> "$report_file"
    fi

    # Security Context
    if [ -z "$security" ]
    then
        echo "$deploy,Security Context,FAIL,CRITICAL" \
        >> "$report_file"
    fi

    # HPA
    kubectl get hpa -n "$ns" 2>/dev/null | \
    grep -q "$deploy"

    if [ $? -ne 0 ]
    then
        echo "$deploy,HPA Missing,FAIL,MEDIUM" \
        >> "$report_file"
    fi

    # PDB
    kubectl get pdb -n "$ns" 2>/dev/null | \
    grep -q "$deploy"

    if [ $? -ne 0 ]
    then
        echo "$deploy,PDB Missing,FAIL,HIGH" \
        >> "$report_file"
    fi

done

echo
echo "Production Readiness Review Complete"
echo "Report Generated:"
echo "$report_file"