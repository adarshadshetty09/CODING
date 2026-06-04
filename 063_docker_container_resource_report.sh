#!/bin/bash

<<COMMENT
=========================================================
Question:
Monitor Docker containers and alert on
high resource usage.

What this script does:
1. Checks CPU usage
2. Checks memory usage
3. Alerts if memory exceeds 80%
4. Generates health report
=========================================================
COMMENT

threshold=80

echo "========================================================="
echo " DOCKER HEALTH REPORT"
echo "========================================================="

docker stats --no-stream \
--format "{{.Name}} {{.MemPerc}}" \
| while read container memory
do
    usage=$(echo "$memory" | cut -d'.' -f1 | tr -d '%')

    echo "Container : $container"
    echo "Memory Usage : $memory"

    if [ "$usage" -gt "$threshold" ]
    then
        echo "WARNING: High Memory Usage"
    else
        echo "Status: Healthy"
    fi

    echo "-------------------------------------"
done