#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to generate a Docker
container resource usage report.

What this script does:
1. Lists running containers
2. Displays CPU usage
3. Displays memory usage
4. Displays container status
5. Generates monitoring report
=========================================================
COMMENT

echo "========================================================="
echo " DOCKER CONTAINER RESOURCE REPORT"
echo "========================================================="

docker stats --no-stream \
--format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}"