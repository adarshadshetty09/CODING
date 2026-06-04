#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to monitor website health.

What this script does:
1. Sends HTTP request to website
2. Retrieves HTTP status code
3. Checks whether website is reachable
4. Displays UP or DOWN status
5. Helps monitor application availability
=========================================================
COMMENT

# Website URL
url="https://google.com"

# Get HTTP status code
status_code=$(curl -L -o /dev/null -s -w "%{http_code}" "$url")

# Check website status
if [[ "$status_code" -ge 200 && "$status_code" -lt 400 ]]
then
    echo "$url is UP"
    echo "HTTP Status Code: $status_code"
else
    echo "$url is DOWN"
    echo "HTTP Status Code: $status_code"
fi
