#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to analyze Jenkins
pipeline failures and identify reliability
issues in the CI/CD platform.

Scenario:
Over the last month, developers have been
complaining that deployments are failing
frequently.

The DevOps team receives multiple support
tickets every day:

- "Pipeline failed again"
- "Deployment is stuck"
- "Build randomly failed"

Management wants visibility into:

- Which jobs fail most often
- When the last failure occurred
- Which pipelines are unstable
- Which teams are impacted

The DevOps team must generate a report
showing the most problematic pipelines.

Purpose:
Improve CI/CD platform reliability and
identify pipelines requiring attention.

What this script does:
1. Connects to Jenkins
2. Retrieves all jobs
3. Identifies failed jobs
4. Retrieves last build status
5. Retrieves last failure timestamp
6. Generates failure analysis report
7. Highlights unstable pipelines

Prerequisites:
- Jenkins API accessible
- curl installed
- jq installed
- Jenkins API token available

Expected Output:
Job,Status,LastFailure,Risk

Real-world Use Case:
Used by DevOps Engineers and Platform
Teams to improve CI/CD reliability and
reduce deployment failures.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

jenkins_url="http://jenkins.company.com"
username="admin"
api_token="your_api_token"

report_file="jenkins_failure_report.csv"

echo "Job,Status,LastFailure,Risk" > "$report_file"

# =====================================================
# Get Jenkins Jobs
# =====================================================

jobs=$(curl -s \
-u "$username:$api_token" \
"$jenkins_url/api/json" | \
jq -r '.jobs[].name')

# =====================================================
# Analyze Jobs
# =====================================================

for job in $jobs
do

    echo "Analyzing $job..."

    job_data=$(curl -s \
    -u "$username:$api_token" \
    "$jenkins_url/job/$job/api/json")

    result=$(echo "$job_data" | \
    jq -r '.lastBuild.result')

    timestamp=$(echo "$job_data" | \
    jq -r '.lastBuild.timestamp')

    if [ "$timestamp" != "null" ]
    then
        last_failure=$(date -d @"$((timestamp/1000))")
    else
        last_failure="N/A"
    fi

    if [ "$result" = "FAILURE" ]
    then
        risk="HIGH"

        echo "$job,$result,$last_failure,$risk" \
        >> "$report_file"

    elif [ "$result" = "UNSTABLE" ]
    then
        risk="MEDIUM"

        echo "$job,$result,$last_failure,$risk" \
        >> "$report_file"
    fi

done

# =====================================================
# Completion
# =====================================================

echo
echo "========================================="
echo " Jenkins Failure Analysis Complete"
echo "========================================="

echo
echo "Report Generated:"
echo "$report_file"

cat "$report_file"