#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to audit MySQL
replication health.

Scenario:
The company runs a highly available MySQL
environment consisting of:

- Primary MySQL Server
- Replica MySQL Server

Last week a production incident occurred.

Replication stopped due to a network issue,
but nobody noticed for several hours.

Orders were still being written to the
primary database, causing the replica to
fall behind significantly.

Management now requires an automated
replication health audit.

The DBA and DevOps teams must verify:

- Replica IO Thread Status
- Replica SQL Thread Status
- Replication Lag
- Replica Connectivity
- Replication Health

Purpose:
Detect replication failures before they
impact disaster recovery and reporting
systems.

What this script does:
1. Connects to MySQL
2. Checks replication status
3. Verifies IO thread
4. Verifies SQL thread
5. Checks replication lag
6. Generates health report
7. Produces HEALTHY / UNHEALTHY status

Prerequisites:
- MySQL client installed
- Replica server configured
- User has REPLICATION CLIENT privilege

Expected Output:
mysql_replication_report.txt

Replication Status:
HEALTHY / UNHEALTHY

Real-world Use Case:
Used by DBAs, DevOps Engineers and SREs
to monitor database replication health.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

mysql_user="root"
mysql_password="password"

report_file="mysql_replication_report.txt"

status=0

# =====================================================
# Report Header
# =====================================================

{
echo "========================================="
echo " MYSQL REPLICATION HEALTH REPORT"
echo "========================================="
echo "Generated: $(date)"
echo
} > "$report_file"

# =====================================================
# Collect Replication Information
# =====================================================

replication_output=$(mysql -u"$mysql_user" \
-p"$mysql_password" \
-e "SHOW REPLICA STATUS\G" 2>/dev/null)

# For MySQL 5.x:
# SHOW SLAVE STATUS\G

if [ -z "$replication_output" ]
then
    echo "[FAIL] Unable To Retrieve Replication Status" \
    >> "$report_file"

    status=1
else

    io_status=$(echo "$replication_output" \
    | awk -F': ' '/Replica_IO_Running/ {print $2}')

    sql_status=$(echo "$replication_output" \
    | awk -F': ' '/Replica_SQL_Running/ {print $2}')

    lag=$(echo "$replication_output" \
    | awk -F': ' '/Seconds_Behind_Source/ {print $2}')

    # =================================================
    # IO Thread Check
    # =================================================

    if [ "$io_status" = "Yes" ]
    then
        echo "[PASS] IO Thread Running" \
        >> "$report_file"
    else
        echo "[FAIL] IO Thread Stopped" \
        >> "$report_file"

        status=1
    fi

    # =================================================
    # SQL Thread Check
    # =================================================

    if [ "$sql_status" = "Yes" ]
    then
        echo "[PASS] SQL Thread Running" \
        >> "$report_file"
    else
        echo "[FAIL] SQL Thread Stopped" \
        >> "$report_file"

        status=1
    fi

    # =================================================
    # Replication Lag Check
    # =================================================

    if [ -z "$lag" ]
    then
        echo "[FAIL] Replication Lag Unknown" \
        >> "$report_file"

        status=1

    elif [ "$lag" -lt 60 ]
    then
        echo "[PASS] Replication Lag: ${lag}s" \
        >> "$report_file"

    else
        echo "[FAIL] High Replication Lag: ${lag}s" \
        >> "$report_file"

        status=1
    fi

fi

# =====================================================
# Final Result
# =====================================================

{
echo
echo "========================================="
echo " FINAL RESULT"
echo "========================================="
} >> "$report_file"

if [ "$status" -eq 0 ]
then
    {
    echo "REPLICATION STATUS : HEALTHY"
    echo "Replication operating normally."
    } >> "$report_file"
else
    {
    echo "REPLICATION STATUS : UNHEALTHY"
    echo "Immediate investigation required."
    } >> "$report_file"
fi

# =====================================================
# Completion
# =====================================================

echo
echo "MySQL Replication Audit Complete"
echo "Report Generated:"
echo "$report_file"

if [ "$status" -eq 0 ]
then
    echo "REPLICATION STATUS : HEALTHY"
else
    echo "REPLICATION STATUS : UNHEALTHY"
fi