#!/bin/bash

log_file="/var/log/auth.log"

echo "================================="
echo " FAILED SSH LOGIN REPORT"
echo "================================="

grep "Failed password" "$log_file" \
| awk '{print $(NF-3)}' \
| sort \
| uniq -c \
| sort -nr \
| while read count ip
do
    echo "$ip : $count failed attempts"
done