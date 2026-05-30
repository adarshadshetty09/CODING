#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to check Jenkins
job status using Jenkins API.

What this script does:
1. Connects to Jenkins API
2. Retrieves latest build status
3. Displays job health
4. Helps monitor CI/CD pipelines
=========================================================
COMMENT

jenkins_url="http://localhost:8080"
job_name="sample-job"

status=$(curl -s \
"$jenkins_url/job/$job_name/lastBuild/api/json" \
| jq -r '.result')

echo "================================="
echo " JENKINS JOB STATUS REPORT"
echo "================================="

echo "Job Name : $job_name"
echo "Status   : $status"

if [ "$status" = "SUCCESS" ]
then
    echo "Build Successful"
else
    echo "Build Failed"
fi