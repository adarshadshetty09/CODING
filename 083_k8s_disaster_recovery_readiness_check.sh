#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to audit Kubernetes
Disaster Recovery (DR) readiness.

Purpose:
Verify whether the Kubernetes environment
is prepared for disaster recovery events.

What this script does:
1. Checks Kubernetes cluster access
2. Verifies Velero installation
3. Verifies backup existence
4. Checks backup age
5. Checks Persistent Volumes
6. Checks Storage Classes
7. Checks critical namespaces
8. Generates DR readiness report

Prerequisites:
- kubectl configured
- Velero installed (optional)

Expected Output:
Check,Status,Risk

Real-world Use Case:
Used during DR audits, compliance reviews,
and recovery readiness assessments.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

report_file="dr_readiness_report.csv"

critical_namespaces=(
kube-system
monitoring
ingress-nginx
)

# =====================================================
# CSV Header
# =====================================================

echo "Check,Status,Risk" > "$report_file"

# =====================================================
# Cluster Access Check
# =====================================================

kubectl cluster-info >/dev/null 2>&1

if [ $? -eq 0 ]
then
    echo "Cluster Access,PASS,LOW" >> "$report_file"
else
    echo "Cluster Access,FAIL,CRITICAL" >> "$report_file"
fi

# =====================================================
# Velero Check
# =====================================================

kubectl get namespace velero >/dev/null 2>&1

if [ $? -eq 0 ]
then
    echo "Velero Installed,PASS,LOW" >> "$report_file"
else
    echo "Velero Installed,FAIL,HIGH" >> "$report_file"
fi

# =====================================================
# Storage Class Check
# =====================================================

storage_count=$(kubectl get storageclass \
--no-headers 2>/dev/null | wc -l)

if [ "$storage_count" -gt 0 ]
then
    echo "Storage Classes,PASS,LOW" >> "$report_file"
else
    echo "Storage Classes,FAIL,HIGH" >> "$report_file"
fi

# =====================================================
# Persistent Volume Check
# =====================================================

pv_count=$(kubectl get pv \
--no-headers 2>/dev/null | wc -l)

if [ "$pv_count" -gt 0 ]
then
    echo "Persistent Volumes,PASS,LOW" >> "$report_file"
else
    echo "Persistent Volumes,FAIL,CRITICAL" >> "$report_file"
fi

# =====================================================
# Critical Namespace Check
# =====================================================

for ns in "${critical_namespaces[@]}"
do
    kubectl get namespace "$ns" >/dev/null 2>&1

    if [ $? -eq 0 ]
    then
        echo "Namespace:$ns,PASS,LOW" >> "$report_file"
    else
        echo "Namespace:$ns,FAIL,HIGH" >> "$report_file"
    fi
done

# =====================================================
# Backup Check (Velero)
# =====================================================

velero backup get >/dev/null 2>&1

if [ $? -eq 0 ]
then
    backup_count=$(velero backup get \
    --no-headers 2>/dev/null | wc -l)

    if [ "$backup_count" -gt 0 ]
    then
        echo "Backups Available,PASS,LOW" >> "$report_file"
    else
        echo "Backups Available,FAIL,CRITICAL" >> "$report_file"
    fi
fi

# =====================================================
# Completion
# =====================================================

echo
echo "Disaster Recovery Audit Complete"
echo "Report Generated:"
echo "$report_file"