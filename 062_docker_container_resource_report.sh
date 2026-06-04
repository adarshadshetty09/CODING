#!/bin/bash

<<COMMENT
=========================================================
Question:
Generate detailed Docker container
resource usage report.

What this script does:
1. Lists running containers
2. Displays CPU usage
3. Displays memory usage
4. Displays container status
5. Helps monitor Docker workloads
=========================================================
COMMENT

echo "========================================================="
echo " DOCKER RESOURCE REPORT"
echo "========================================================="

printf "%-20s %-10s %-20s %-10s\n" \
"CONTAINER" "CPU%" "MEMORY" "MEM%"

docker stats --no-stream \
--format "{{.Name}} {{.CPUPerc}} {{.MemUsage}} {{.MemPerc}}" \
| while read name cpu mem_usage mem_perc
do
    printf "%-20s %-10s %-20s %-10s\n" \
    "$name" "$cpu" "$mem_usage" "$mem_perc"
done