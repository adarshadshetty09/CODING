#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to identify AWS cost
optimization opportunities.

Scenario:
The company's AWS bill increased from:

$25,000/month
to
$38,000/month

within three months.

Management has asked the Cloud Engineering
team to reduce cloud spending without
impacting production services.

A preliminary investigation suggests:

- Idle EC2 instances
- Unattached EBS volumes
- Unused Elastic IPs
- Old EBS snapshots
- Idle Load Balancers

may be contributing to unnecessary costs.

The DevOps team must generate a report
showing potential optimization areas.

Purpose:
Identify cloud resources that may be
increasing AWS costs unnecessarily.

What this script does:
1. Finds stopped EC2 instances
2. Finds unattached EBS volumes
3. Finds unused Elastic IPs
4. Finds old EBS snapshots
5. Finds idle Load Balancers
6. Generates cost optimization report
7. Highlights potential savings

Prerequisites:
- AWS CLI installed
- AWS credentials configured
- Read access to AWS resources

Expected Output:
Resource,Issue,Risk

Real-world Use Case:
Used by Cloud Engineers, DevOps Engineers,
Platform Engineers and FinOps teams during
monthly cloud cost reviews.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

report_file="aws_cost_optimization_report.csv"

echo "Resource,Issue,Risk" > "$report_file"

# =====================================================
# Stopped EC2 Instances
# =====================================================

echo "Checking stopped EC2 instances..."

aws ec2 describe-instances \
--filters "Name=instance-state-name,Values=stopped" \
--query 'Reservations[*].Instances[*].InstanceId' \
--output text | while read instance
do
    echo "$instance,Stopped EC2 Instance,MEDIUM" \
    >> "$report_file"
done

# =====================================================
# Unattached EBS Volumes
# =====================================================

echo "Checking unattached EBS volumes..."

aws ec2 describe-volumes \
--filters Name=status,Values=available \
--query 'Volumes[*].VolumeId' \
--output text | while read volume
do
    echo "$volume,Unattached EBS Volume,HIGH" \
    >> "$report_file"
done

# =====================================================
# Unused Elastic IPs
# =====================================================

echo "Checking unused Elastic IPs..."

aws ec2 describe-addresses \
--query 'Addresses[?AssociationId==null].PublicIp' \
--output text | while read ip
do
    echo "$ip,Unused Elastic IP,HIGH" \
    >> "$report_file"
done

# =====================================================
# Old Snapshots (>180 Days)
# =====================================================

echo "Checking old snapshots..."

aws ec2 describe-snapshots \
--owner-ids self \
--query 'Snapshots[*].[SnapshotId,StartTime]' \
--output text | while read snapshot date
do

    snapshot_epoch=$(date -d "$date" +%s)
    current_epoch=$(date +%s)

    age_days=$(( (current_epoch-snapshot_epoch)/86400 ))

    if [ "$age_days" -gt 180 ]
    then
        echo "$snapshot,Old Snapshot (${age_days} Days),LOW" \
        >> "$report_file"
    fi

done

# =====================================================
# Classic Load Balancers
# =====================================================

echo "Checking Load Balancers..."

aws elb describe-load-balancers \
--query 'LoadBalancerDescriptions[*].LoadBalancerName' \
--output text | while read lb
do

    instance_count=$(aws elb describe-load-balancers \
    --load-balancer-names "$lb" \
    --query \
    'LoadBalancerDescriptions[*].Instances[*].InstanceId' \
    --output text | wc -w)

    if [ "$instance_count" -eq 0 ]
    then
        echo "$lb,Idle Load Balancer,HIGH" \
        >> "$report_file"
    fi

done

# =====================================================
# Completion
# =====================================================

echo
echo "========================================="
echo " AWS Cost Optimization Audit Complete"
echo "========================================="

echo
echo "Report Generated:"
echo "$report_file"

cat "$report_file"