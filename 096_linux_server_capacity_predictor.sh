#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to predict Linux server
disk capacity exhaustion.

Scenario:
The company operates 50 Linux servers.

Recently several production incidents
occurred because disks became full.

Management wants proactive reporting
before outages occur.

The Operations team must identify servers
that are approaching critical disk usage.

Any filesystem above 80% should be flagged
for review.

Any filesystem above 90% should be
considered high risk.

Purpose:
Identify storage capacity risks before
production services are impacted.

What this script does:
1. Checks all mounted filesystems
2. Collects disk utilization
3. Classifies risk level
4. Generates capacity assessment report
5. Highlights critical filesystems

Prerequisites:
- Linux server
- df command available

Expected Output:
Filesystem,Usage,Risk

Real-world Use Case:
Used by Linux Administrators, DevOps
Engineers and SRE teams during capacity
planning reviews.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

report_file="capacity_report.csv"

echo "Filesystem,Usage,Risk" > "$report_file"

# =====================================================
# Analyze Filesystems
# =====================================================

df -hP | tail -n +2 | while read fs size used avail usage mount
do

    percent=$(echo "$usage" | tr -d '%')

    if [ "$percent" -ge 90 ]
    then
        risk="CRITICAL"
    elif [ "$percent" -ge 80 ]
    then
        risk="HIGH"
    elif [ "$percent" -ge 60 ]
    then
        risk="MEDIUM"
    else
        risk="LOW"
    fi

    echo "$mount,$usage,$risk" >> "$report_file"

done

# =====================================================
# Completion
# =====================================================

echo
echo "Capacity Assessment Complete"
echo "Report Generated:"
echo "$report_file"

cat "$report_file"