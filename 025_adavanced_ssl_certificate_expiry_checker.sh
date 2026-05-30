#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to check SSL certificate
expiry dates for multiple domains.

What this script does:
1. Connects to HTTPS websites
2. Retrieves certificate expiry dates
3. Calculates remaining days
4. Alerts if expiry is within 30 days
=========================================================
COMMENT

# List of domains
domains=("google.com" "github.com" "amazon.com")

# Alert threshold
threshold=30

for domain in "${domains[@]}"
do
    echo "================================="
    echo "Checking: $domain"
    echo "================================="

    expiry_date=$(echo | openssl s_client -connect ${domain}:443 2>/dev/null \
    | openssl x509 -noout -enddate \
    | cut -d= -f2)

    expiry_epoch=$(date -d "$expiry_date" +%s)
    current_epoch=$(date +%s)

    days_left=$(( (expiry_epoch - current_epoch) / 86400 ))

    echo "Certificate expires in $days_left days"

    if [ "$days_left" -lt "$threshold" ]
    then
        echo "WARNING: SSL certificate expires within $threshold days"
    else
        echo "SSL certificate is healthy"
    fi

    echo ""
done