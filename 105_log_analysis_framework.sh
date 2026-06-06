#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a reusable Log Analysis Framework
for Linux production environments.

Scenario:
09:00 AM

Management reports that customers experienced
intermittent application failures overnight.

Several teams are involved:

- Application Team
- Database Team
- Infrastructure Team
- DevOps Team

Everyone is asking:

What failed?
When did it fail?
How many errors occurred?
Which component generated errors?

Manually searching large log files takes
too much time.

The Operations team wants a reusable
framework that can analyze any log file
and generate an error summary report.

Purpose:
Reduce troubleshooting time and help
identify application issues quickly.

What this script does:
1. Accepts a log file as input
2. Counts total log lines
3. Counts ERROR entries
4. Counts WARNING entries
5. Finds top error messages
6. Finds error spikes
7. Generates analysis report

Prerequisites:
- Linux server
- grep
- awk
- sort
- uniq

Expected Output:
log_analysis_report.txt

Risk Level:
LOW / MEDIUM / HIGH / CRITICAL

Real-world Use Case:
Used by SRE, DevOps and Operations teams
during incident investigations.

=========================================================
COMMENT

# =====================================================
# Input Validation
# =====================================================

log_file="$1"

if [ -z "$log_file" ]
then
    echo "Usage: $0 <logfile>"
    exit 1
fi

if [ ! -f "$log_file" ]
then
    echo "Log file not found"
    exit 1
fi

# =====================================================
# Configuration
# =====================================================

report_file="log_analysis_report.txt"

# =====================================================
# Report Header
# =====================================================

{
echo "========================================="
echo " LOG ANALYSIS REPORT"
echo "========================================="
echo "Log File : $log_file"
echo "Generated: $(date)"
echo
} > "$report_file"

# =====================================================
# Statistics
# =====================================================

total_lines=$(wc -l < "$log_file")

error_count=$(grep -ci "error" "$log_file")

warning_count=$(grep -ci "warning" "$log_file")

critical_count=$(grep -ci "critical" "$log_file")

# =====================================================
# Basic Summary
# =====================================================

{
echo "===== SUMMARY ====="
echo "Total Lines     : $total_lines"
echo "Errors          : $error_count"
echo "Warnings        : $warning_count"
echo "Critical Events : $critical_count"
echo
} >> "$report_file"

# =====================================================
# Top Error Messages
# =====================================================

{
echo "===== TOP ERROR MESSAGES ====="

grep -i "error" "$log_file" \
| sort \
| uniq -c \
| sort -rn \
| head -10

echo
} >> "$report_file"

# =====================================================
# Top Warning Messages
# =====================================================

{
echo "===== TOP WARNING MESSAGES ====="

grep -i "warning" "$log_file" \
| sort \
| uniq -c \
| sort -rn \
| head -10

echo
} >> "$report_file"

# =====================================================
# Error Timeline
# =====================================================

{
echo "===== ERROR TIMELINE ====="

grep -i "error" "$log_file" \
| awk '{print $1,$2}' \
| sort \
| uniq -c \
| sort -rn \
| head -10

echo
} >> "$report_file"

# =====================================================
# Risk Assessment
# =====================================================

if [ "$critical_count" -gt 20 ]
then
    risk="CRITICAL"
elif [ "$error_count" -gt 100 ]
then
    risk="HIGH"
elif [ "$warning_count" -gt 100 ]
then
    risk="MEDIUM"
else
    risk="LOW"
fi

{
echo "========================================="
echo " FINAL RESULT"
echo "========================================="
echo "Risk Level : $risk"
} >> "$report_file"

# =====================================================
# Completion
# =====================================================

echo
echo "Log Analysis Complete"
echo "Report Generated:"
echo "$report_file"

echo "Risk Level: $risk"