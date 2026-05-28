#!/bin/bash

# Get disk usage percentage of root filesystem (/)
usage=$(df -h / | awk 'NR==2 {print $5}' | cut -d'%' -f1)

# Compare with threshold
if [ "$usage" -gt 80 ]
then
    echo "WARNING: Disk usage exceeded threshold: ${usage}%"
else
    echo "Disk usage is normal: ${usage}%"
fi