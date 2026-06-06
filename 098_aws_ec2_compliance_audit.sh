#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to audit AWS EC2
instances for compliance violations.

Scenario:
The company is preparing for a Security
and Compliance Audit.

The Cloud Governance team discovered that
many EC2 instances were created manually
by different teams over several years.

Management wants a report identifying
instances that violate company standards.

The audit must identify:

- Missing Owner tag
- Missing Environment tag
- Public IP assigned
- Unencrypted EBS volumes
- Instances older than 1 year

Purpose:
Improve cloud governance, security and
cost visibility across AWS accounts.

What this script does:
1. Retrieves EC2 instances
2. Checks required tags
3. Checks public IP assignment
4. Checks EBS encryption
5. Checks instance age
6. Generates compliance report
7. Classifies risk level

Prerequisites:
- AWS CLI installed
- AWS credentials configured
- EC2 read permissions

Expected Output:
InstanceId,Issue,Risk

Real-world Use Case:
Used by Cloud Engineers, Security Teams,
DevOps Engineers and FinOps teams during
compliance and governance reviews.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

report_file="ec2_compliance_report.csv"

echo "InstanceId,Issue,Risk" > "$report_file"

# =====================================================
# Get EC2 Instances
# =====================================================

instances=$(aws ec2 describe-instances \
--query 'Reservations[*].Instances[*].[InstanceId,LaunchTime,PublicIpAddress]' \
--output text)

# =====================================================
# Process Instances
# =====================================================

while read instance_id launch_time public_ip
do

    echo "Auditing $instance_id ..."

    # =================================================
    # Owner Tag Check
    # =================================================

    owner=$(aws ec2 describe-tags \
    --filters "Name=resource-id,Values=$instance_id" \
    "Name=key,Values=Owner" \
    --query 'Tags[*].Value' \
    --output text)

    if [ -z "$owner" ]
    then
        echo "$instance_id,Missing Owner Tag,HIGH" \
        >> "$report_file"
    fi

    # =================================================
    # Environment Tag Check
    # =================================================

    environment=$(aws ec2 describe-tags \
    --filters "Name=resource-id,Values=$instance_id" \
    "Name=key,Values=Environment" \
    --query 'Tags[*].Value' \
    --output text)

    if [ -z "$environment" ]
    then
        echo "$instance_id,Missing Environment Tag,MEDIUM" \
        >> "$report_file"
    fi

    # =================================================
    # Public IP Check
    # =================================================

    if [ -n "$public_ip" ] && [ "$public_ip" != "None" ]
    then
        echo "$instance_id,Public IP Assigned,HIGH" \
        >> "$report_file"
    fi

    # =================================================
    # Instance Age Check
    # =================================================

    launch_epoch=$(date -d "$launch_time" +%s)
    current_epoch=$(date +%s)

    age_days=$(( (current_epoch - launch_epoch) / 86400 ))

    if [ "$age_days" -gt 365 ]
    then
        echo "$instance_id,Instance Older Than 1 Year,LOW" \
        >> "$report_file"
    fi

    # =================================================
    # EBS Encryption Check
    # =================================================

    volume_ids=$(aws ec2 describe-instances \
    --instance-ids "$instance_id" \
    --query \
    'Reservations[*].Instances[*].BlockDeviceMappings[*].Ebs.VolumeId' \
    --output text)

    for volume in $volume_ids
    do

        encrypted=$(aws ec2 describe-volumes \
        --volume-ids "$volume" \
        --query 'Volumes[*].Encrypted' \
        --output text)

        if [ "$encrypted" != "True" ]
        then
            echo "$instance_id,Unencrypted EBS Volume,CRITICAL" \
            >> "$report_file"
        fi

    done

done <<< "$instances"

# =====================================================
# Completion
# =====================================================

echo
echo "========================================="
echo " EC2 Compliance Audit Complete"
echo "========================================="

echo
echo "Report Generated:"
echo "$report_file"

cat "$report_file"