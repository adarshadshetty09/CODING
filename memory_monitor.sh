#!/bin/bash

usage=$(free | awk '/Mem/ {printf("%.0f"), $3/$2 * 100}')

if [ "$usage" -gt 80 ]
then
    echo "WARNING: Memory usage is high: ${usage}%"
else
    echo "Memory usage is normal: ${usage}%"
fi