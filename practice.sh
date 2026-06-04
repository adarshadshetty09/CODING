#!/bin/bash 

usage=$(df -h / | awk 'NR==2 {print $5}' | cut -d'%' -f1)

if [ "$usage" -gt 80]
then
    echo "WARNING: Disk usage exceeded threshhold: ${usage}%"
else
    echo "Disk usage is normal: ${usage}%"
fi
