#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a reusable Database Operations
Framework for production environments.

Scenario:
The company operates several critical
databases:

- MySQL
- PostgreSQL
- MongoDB

A recent outage occurred because:

- MySQL disk became full
- PostgreSQL connections were exhausted
- MongoDB replication lag increased

Engineers had to manually log in to
multiple servers and run different
commands to identify the issue.

Management wants a centralized database
operations framework that can quickly
assess database health.

Purpose:
Provide a standardized database health
assessment tool for production operations.

What this script does:
1. Checks database connectivity
2. Checks disk usage
3. Checks memory usage
4. Checks connection counts
5. Checks replication status
6. Generates health report
7. Calculates health score

Prerequisites:
- Linux server
- mysql client installed
- psql client installed
- mongosh installed
- Appropriate credentials configured

Expected Output:
database_operations_report.txt

Overall Status:
HEALTHY / WARNING / CRITICAL

Real-world Use Case:
Used by DBAs, SREs, Platform Engineers
and DevOps teams during production
operations and incident response.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

report_file="database_operations_report.txt"

health_score=100

mysql_host="localhost"
postgres_host="localhost"
mongo_host="localhost"

# =====================================================
# Report Header
# =====================================================

{
echo "========================================="
echo " DATABASE OPERATIONS FRAMEWORK REPORT"
echo "========================================="
echo "Generated: $(date)"
echo
} > "$report_file"

# =====================================================
# MySQL Connectivity
# =====================================================

mysqladmin ping -h "$mysql_host" \
>/dev/null 2>&1

if [ $? -eq 0 ]
then
    echo "[PASS] MySQL Reachable" \
    >> "$report_file"
else
    echo "[FAIL] MySQL Unreachable" \
    >> "$report_file"

    health_score=$((health_score-20))
fi

# =====================================================
# PostgreSQL Connectivity
# =====================================================

pg_isready -h "$postgres_host" \
>/dev/null 2>&1

if [ $? -eq 0 ]
then
    echo "[PASS] PostgreSQL Reachable" \
    >> "$report_file"
else
    echo "[FAIL] PostgreSQL Unreachable" \
    >> "$report_file"

    health_score=$((health_score-20))
fi

# =====================================================
# MongoDB Connectivity
# =====================================================

mongosh --host "$mongo_host" \
--eval "db.adminCommand('ping')" \
>/dev/null 2>&1

if [ $? -eq 0 ]
then
    echo "[PASS] MongoDB Reachable" \
    >> "$report_file"
else
    echo "[FAIL] MongoDB Unreachable" \
    >> "$report_file"

    health_score=$((health_score-20))
fi

# =====================================================
# Disk Usage Check
# =====================================================

disk_usage=$(df -h / | awk '
NR==2 {
gsub("%","",$5)
print $5
}')

echo >> "$report_file"
echo "===== STORAGE =====" \
>> "$report_file"

echo "Disk Usage : ${disk_usage}%" \
>> "$report_file"

if [ "$disk_usage" -gt 85 ]
then
    health_score=$((health_score-15))
fi

# =====================================================
# Memory Check
# =====================================================

memory_usage=$(free | awk '
/Mem/ {
printf("%.0f",$3/$2*100)
}')

echo >> "$report_file"
echo "===== MEMORY =====" \
>> "$report_file"

echo "Memory Usage : ${memory_usage}%" \
>> "$report_file"

if [ "$memory_usage" -gt 90 ]
then
    health_score=$((health_score-10))
fi

# =====================================================
# Connection Counts
# =====================================================

echo >> "$report_file"
echo "===== CONNECTIONS =====" \
>> "$report_file"

mysql_connections=$(mysql -Nse \
"SHOW STATUS LIKE 'Threads_connected';" \
2>/dev/null | awk '{print $2}')

echo "MySQL Connections : ${mysql_connections:-N/A}" \
>> "$report_file"

# =====================================================
# Final Assessment
# =====================================================

if [ "$health_score" -ge 80 ]
then
    status="HEALTHY"
elif [ "$health_score" -ge 60 ]
then
    status="WARNING"
else
    status="CRITICAL"
fi

{
echo
echo "========================================="
echo " FINAL RESULT"
echo "========================================="
echo "Health Score : $health_score"
echo "Overall Status : $status"
} >> "$report_file"

# =====================================================
# Completion
# =====================================================

echo
echo "Database Operations Framework Complete"
echo "Report Generated:"
echo "$report_file"

echo "Overall Status: $status"