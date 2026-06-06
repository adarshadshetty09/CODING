#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to audit Kubernetes
security compliance.

Purpose:
Identify workloads that violate Kubernetes
security best practices.

What this script does:
1. Scans deployments in all namespaces
2. Detects :latest image usage
3. Detects missing securityContext
4. Detects privileged containers
5. Detects containers running as root
6. Detects HostPath volume usage
7. Detects missing resource limits
8. Generates security audit report

Prerequisites:
- kubectl installed
- Cluster access available

Expected Output:
Namespace,Deployment,Issue,Severity

Real-world Use Case:
Used during security reviews, compliance
audits and platform governance checks.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

report_file="security_compliance_report.csv"

echo "Namespace,Deployment,Issue,Severity" \
> "$report_file"

# =====================================================
# Get Deployments
# =====================================================

deployments=$(kubectl get deployments -A --no-headers)

# =====================================================
# Process Deployments
# =====================================================

echo "$deployments" | while read namespace deployment ready up_to_date available age
do

    image=$(kubectl get deployment "$deployment" \
    -n "$namespace" \
    -o jsonpath='{.spec.template.spec.containers[0].image}')

    privileged=$(kubectl get deployment "$deployment" \
    -n "$namespace" \
    -o jsonpath='{.spec.template.spec.containers[0].securityContext.privileged}')

    run_as_root=$(kubectl get deployment "$deployment" \
    -n "$namespace" \
    -o jsonpath='{.spec.template.spec.securityContext.runAsNonRoot}')

    security_context=$(kubectl get deployment "$deployment" \
    -n "$namespace" \
    -o jsonpath='{.spec.template.spec.containers[0].securityContext}')

    cpu_limit=$(kubectl get deployment "$deployment" \
    -n "$namespace" \
    -o jsonpath='{.spec.template.spec.containers[0].resources.limits.cpu}')

    hostpath=$(kubectl get deployment "$deployment" \
    -n "$namespace" \
    -o jsonpath='{.spec.template.spec.volumes[*].hostPath.path}')

    # Latest Tag Check
    echo "$image" | grep -q ":latest"

    if [ $? -eq 0 ]
    then
        echo "$namespace,$deployment,Using Latest Image Tag,HIGH" \
        >> "$report_file"
    fi

    # Missing Security Context
    if [ -z "$security_context" ]
    then
        echo "$namespace,$deployment,Missing Security Context,HIGH" \
        >> "$report_file"
    fi

    # Privileged Container
    if [ "$privileged" = "true" ]
    then
        echo "$namespace,$deployment,Privileged Container,CRITICAL" \
        >> "$report_file"
    fi

    # Running As Root
    if [ "$run_as_root" != "true" ]
    then
        echo "$namespace,$deployment,May Run As Root,CRITICAL" \
        >> "$report_file"
    fi

    # HostPath Usage
    if [ -n "$hostpath" ]
    then
        echo "$namespace,$deployment,HostPath Volume Detected,HIGH" \
        >> "$report_file"
    fi

    # Missing Resource Limits
    if [ -z "$cpu_limit" ]
    then
        echo "$namespace,$deployment,Missing Resource Limits,MEDIUM" \
        >> "$report_file"
    fi

done

echo
echo "Security Audit Complete"
echo "Report Generated:"
echo "$report_file"