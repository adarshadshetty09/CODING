#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to analyze application logs
and display ERROR messages.

What this script does:
1. Reads the log file (app.log)
2. Counts total number of ERROR entries
3. Displays total ERROR count
4. Prints all ERROR messages
5. Removes ERROR keyword from output
=========================================================
COMMENT

# Count total number of ERROR lines
error_count=$(grep -c "ERROR" app.log)

# Display total ERROR count
echo "Total ERROR count: $error_count"
echo ""

# Display ERROR messages
echo "ERRORS:"

# Print only ERROR message text
grep "ERROR" app.log | cut -d' ' -f2-