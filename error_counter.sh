#!/bin/bash

error_count=$(grep -c "ERROR" app.log)

echo "Total ERROR count: $error_count"
echo ""
echo "ERRORS: "

grep "ERROR" app.log | cut -d' ' -f2-