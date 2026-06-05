#!/bin/bash

before=$(df / | awk 'NR==2 {print $3}')

# Cleanup Tasks
find /var/log -name "*.log" -mtime +30 -delete

after=$(df / | awk 'NR==2 {print $3}')

recovered=$((before - after))

echo "Recovered Space: ${recovered} KB"