#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a reusable AWS Operations Framework
for cloud infrastructure auditing.

Scenario:
The company operates a large AWS
environment consisting of:

- 200 EC2 Instances
- 300 EBS Volumes
- 50 Load Balancers
- Multiple Elastic IPs
- Several VPCs

During production incidents engineers
manually execute multiple AWS CLI commands.

This process is slow and inconsistent.

Management wants a single operational
framework that provides an infrastructure
health overview.

The Cloud Engineering team must build a
reusable AWS operations tool.

Purpose:
Provide a centralized AWS operational
health and inventory report.

What this script does:
1. Audits EC2 instances
2. Audits EBS volumes
3. Audits Elastic IPs
4. Audits Load Balancers
5. Generates infrastructure report
6. Highlights operational risks

Prerequisites:
- AWS CLI installed
- AWS credentials configured
- Read access to AWS resources

Expected Output:
aws_operations_report.txt

Overall Status:
HEALTHY / WARNING / CRITICAL

Real-world Use Case:
Used by Cloud Engineers, DevOps Engineers,
SREs and Platform Teams during operational
reviews and incident response.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

report_file="aws_operations_report.txt"

health_score=100

# =====================================================
# Report Header
# =====================================================

{
echo "========================================="
echo " AWS OPERATIONS FRAMEWORK REPORT"
echo "========================================="
echo "Generated: $(date)"
echo
} > "$report_file"

# =====================================================
# EC2 Inventory
# =====================================================

running_instances=$(aws ec2 describe-instances \
--filters Name=instance-state-name,Values=running \
--query 'Reservations[*].Instances[*].InstanceId' \
--output text | wc -w)

stopped_instances=$(aws ec2 describe-instances \
--filters Name=instance-state-name,Values=stopped \
--query 'Reservations[*].Instances[*].InstanceId' \
--output text | wc -w)

{
echo "===== EC2 INSTANCES ====="
echo "Running Instances : $running_instances"
echo "Stopped Instances : $stopped_instances"
echo
} >> "$report_file"

if [ "$stopped_instances" -gt 20 ]
then
    health_score=$((health_score-10))
fi

# =====================================================
# EBS Volumes
# =====================================================

available_volumes=$(aws ec2 describe-volumes \
--filters Name=status,Values=available \
--query 'Volumes[*].VolumeId' \
--output text | wc -w)

{
echo "===== EBS VOLUMES ====="
echo "Unattached Volumes : $available_volumes"
echo
} >> "$report_file"

if [ "$available_volumes" -gt 10 ]
then
    health_score=$((health_score-10))
fi

# =====================================================
# Elastic IP Audit
# =====================================================

unused_eips=$(aws ec2 describe-addresses \
--query 'Addresses[?AssociationId==null].PublicIp' \
--output text | wc -w)

{
echo "===== ELASTIC IPS ====="
echo "Unused Elastic IPs : $unused_eips"
echo
} >> "$report_file"

if [ "$unused_eips" -gt 5 ]
then
    health_score=$((health_score-10))
fi

# =====================================================
# Load Balancer Audit
# =====================================================

lb_count=$(aws elb describe-load-balancers \
--query \
'LoadBalancerDescriptions[*].LoadBalancerName' \
--output text | wc -w)

{
echo "===== LOAD BALANCERS ====="
echo "Total Load Balancers : $lb_count"
echo
} >> "$report_file"

# =====================================================
# Snapshot Audit
# =====================================================

snapshot_count=$(aws ec2 describe-snapshots \
--owner-ids self \
--query 'Snapshots[*].SnapshotId' \
--output text | wc -w)

{
echo "===== SNAPSHOTS ====="
echo "Total Snapshots : $snapshot_count"
echo
} >> "$report_file"

# =====================================================
# Final Health Score
# =====================================================

if [ "$health_score" -ge 80 ]
then
    status="HEALTHY"
elif [ "$health_score" -ge 60 ]
then
    status="WARNING"
else
    status="CRITICAL"
fi

{
echo "========================================="
echo " FINAL RESULT"
echo "========================================="
echo "Health Score : $health_score"
echo "Overall Status : $status"
} >> "$report_file"

# =====================================================
# Completion
# =====================================================

echo
echo "AWS Operations Framework Complete"
echo "Report Generated:"
echo "$report_file"

echo "Overall Status: $status"