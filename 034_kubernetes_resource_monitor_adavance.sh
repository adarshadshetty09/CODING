#!/bin/bash

<<COMMENT
=========================================================
Question:
Monitor Kubernetes pod resource usage
and alert on high memory consumption.

What this script does:
1. Retrieves pod resource usage
2. Checks memory consumption
3. Displays alerts for heavy pods
=========================================================
COMMENT

namespace="default"
memory_threshold=500

echo "================================="
echo " KUBERNETES RESOURCE REPORT"
echo "================================="

kubectl top pods -n "$namespace" --no-headers | while read pod cpu memory
do
    mem=$(echo "$memory" | sed 's/Mi//')

    if [ "$mem" -gt "$memory_threshold" ]
    then
        echo "⚠️ Pod: $pod | Memory: $memory"
    else
        echo "✅ Pod: $pod | Memory: $memory"
    fi
done