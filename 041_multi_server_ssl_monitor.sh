#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor SSL
certificate expiry for multiple domains.

What this script does:
1. Checks SSL certificate expiry dates
2. Calculates remaining days
3. Alerts if expiry is near
4. Generates SSL health report
=========================================================
COMMENT

domains=(
"google.com"
"github.com"
"amazon.com"
)

threshold=30

echo "================================="
echo " SSL CERTIFICATE HEALTH REPORT"
echo "================================="

for domain in "${domains[@]}"
do
    expiry_date=$(echo | openssl s_client \
    -connect ${domain}:443 2>/dev/null \
    | openssl x509 -noout -enddate \
    | cut -d= -f2)

    expiry_epoch=$(date -d "$expiry_date" +%s)
    current_epoch=$(date +%s)

    days_left=$(( (expiry_epoch - current_epoch) / 86400 ))

    echo ""
    echo "Domain : $domain"
    echo "Days Left : $days_left"

    if [ "$days_left" -lt "$threshold" ]
    then
        echo "WARNING: Certificate expires within $threshold days"
    else
        echo "Status : HEALTHY"
    fi
done