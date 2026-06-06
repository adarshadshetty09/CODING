#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to perform Kubernetes
production incident triage.

Scenario:
02:15 AM

PagerDuty Alert Triggered

"Customer checkout failures detected"

Multiple Kubernetes alerts are firing.

Management wants an immediate status update.

The SRE team needs a single script that
collects critical troubleshooting data
from the cluster.

Purpose:
Reduce Mean Time To Resolution (MTTR)
by automatically collecting troubleshooting
information during production incidents.

What this script does:
1. Checks node health
2. Checks failed pods
3. Checks pod restart counts
4. Collects warning events
5. Checks deployment availability
6. Generates incident report

Prerequisites:
- kubectl installed
- Cluster access configured

Expected Output:
incident_report.txt

Real-world Use Case:
Used during Sev-1 and Sev-2 production
incidents by SRE and Platform teams.

=========================================================
COMMENT

report_file="incident_report.txt"

echo "===================================" > "$report_file"
echo "K8S INCIDENT TRIAGE REPORT" >> "$report_file"
echo "Generated: $(date)" >> "$report_file"
echo "===================================" >> "$report_file"

echo "" >> "$report_file"
echo "===== NODE STATUS =====" >> "$report_file"
kubectl get nodes >> "$report_file"

echo "" >> "$report_file"
echo "===== FAILED PODS =====" >> "$report_file"
kubectl get pods -A | \
grep -E "CrashLoopBackOff|Error|Pending|ImagePullBackOff" \
>> "$report_file"

echo "" >> "$report_file"
echo "===== HIGH RESTART PODS =====" >> "$report_file"

kubectl get pods -A --no-headers | \
awk '$5 > 5 {print}' >> "$report_file"

echo "" >> "$report_file"
echo "===== WARNING EVENTS =====" >> "$report_file"

kubectl get events -A \
--field-selector type=Warning \
>> "$report_file"

echo "" >> "$report_file"
echo "===== DEPLOYMENT STATUS =====" >> "$report_file"

kubectl get deployments -A >> "$report_file"

echo
echo "Incident Report Generated"
echo "$report_file"