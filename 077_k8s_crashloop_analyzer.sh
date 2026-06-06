#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to identify failed
Kubernetes pods and collect troubleshooting
information.

Purpose:
Help DevOps/SRE engineers quickly investigate
pod failures during production incidents.

What this script does:
1. Finds failed pods
2. Detects CrashLoopBackOff pods
3. Detects ImagePullBackOff pods
4. Detects Error state pods
5. Collects pod descriptions
6. Collects pod logs
7. Generates troubleshooting report

Prerequisites:
- kubectl installed
- Kubernetes cluster access

Expected Output:
Failed Pods Found

Pod Name
Namespace
Status

Logs Collected
Describe Output Collected

Report Generated

Real-world Use Case:
Used during Kubernetes production incidents
to speed up root cause analysis.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

report_file="k8s_troubleshooting_report.txt"

# =====================================================
# Initialize Report
# =====================================================

echo "Kubernetes Troubleshooting Report" > "$report_file"
echo "Generated: $(date)" >> "$report_file"
echo "==========================================" >> "$report_file"

# =====================================================
# Find Failed Pods
# =====================================================

pods=$(kubectl get pods -A --no-headers | \
grep -E "CrashLoopBackOff|Error|ImagePullBackOff|OOMKilled")

# =====================================================
# Check If Any Failed Pods Exist
# =====================================================

if [ -z "$pods" ]
then
    echo "No Failed Pods Found"
    exit 0
fi

# =====================================================
# Process Failed Pods
# =====================================================

echo "$pods" | while read namespace pod rest
do
    echo
    echo "Analyzing Pod: $pod"

    {
        echo
        echo "=========================================="
        echo "Namespace : $namespace"
        echo "Pod       : $pod"
        echo "=========================================="

        echo
        echo "---------- POD STATUS ----------"
        kubectl get pod "$pod" -n "$namespace"

        echo
        echo "---------- POD DESCRIPTION ----------"
        kubectl describe pod "$pod" -n "$namespace"

        echo
        echo "---------- POD LOGS ----------"
        kubectl logs "$pod" -n "$namespace" --tail=50

    } >> "$report_file" 2>&1
done

# =====================================================
# Report Summary
# =====================================================

echo
echo "Investigation Complete"
echo "Report Generated: $report_file"