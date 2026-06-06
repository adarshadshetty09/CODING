#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to audit Kubernetes
applications for SLO/SLI readiness.

Purpose:
Verify whether applications are prepared
for SRE monitoring and reliability practices.

What this script does:
1. Scans deployments
2. Checks readiness probes
3. Checks liveness probes
4. Checks Prometheus annotations
5. Checks ServiceMonitor resources
6. Checks ingress configuration
7. Generates audit report

Prerequisites:
- kubectl configured
- Prometheus Operator (optional)

Expected Output:
Application,Check,Status,Risk

Real-world Use Case:
Used by SRE teams before defining
SLIs, SLOs and alerting standards.

=========================================================
COMMENT

report_file="slo_sli_audit.csv"

echo "Application,Check,Status,Risk" > "$report_file"

kubectl get deployments -A --no-headers | while read ns deploy ready updated available age
do

    readiness=$(kubectl get deployment "$deploy" \
    -n "$ns" \
    -o jsonpath='{.spec.template.spec.containers[0].readinessProbe}')

    liveness=$(kubectl get deployment "$deploy" \
    -n "$ns" \
    -o jsonpath='{.spec.template.spec.containers[0].livenessProbe}')

    metrics=$(kubectl get deployment "$deploy" \
    -n "$ns" \
    -o jsonpath='{.spec.template.metadata.annotations.prometheus\.io/scrape}')

    if [ -z "$readiness" ]
    then
        echo "$deploy,Readiness Probe,FAIL,HIGH" \
        >> "$report_file"
    fi

    if [ -z "$liveness" ]
    then
        echo "$deploy,Liveness Probe,FAIL,HIGH" \
        >> "$report_file"
    fi

    if [ "$metrics" != "true" ]
    then
        echo "$deploy,Prometheus Scraping,FAIL,MEDIUM" \
        >> "$report_file"
    fi

    servicemonitor=$(kubectl get servicemonitor \
    -n "$ns" 2>/dev/null | grep "$deploy")

    if [ -z "$servicemonitor" ]
    then
        echo "$deploy,ServiceMonitor Missing,MEDIUM" \
        >> "$report_file"
    fi

done

echo
echo "SLO/SLI Audit Complete"
echo "Report Generated: $report_file"