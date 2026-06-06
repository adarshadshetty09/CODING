#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to verify database backups.

Purpose:
Ensure that database backups are valid and
can be used for recovery.

What this script does:
1. Finds latest backup file
2. Checks backup exists
3. Checks backup size
4. Verifies archive integrity
5. Generates verification report
6. Returns success/failure exit code

Prerequisites:
- Backup directory exists
- tar command available

Expected Output:
Latest Backup Found
Backup Size Valid
Archive Integrity Verified

Overall Status : SUCCESS

Real-world Use Case:
Used by DevOps/SRE teams to ensure backup
reliability and disaster recovery readiness.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

backup_dir="/backups/mysql"
report_file="backup_verification_report.txt"

status=0

# =====================================================
# Initialize Report
# =====================================================

echo "Database Backup Verification Report" > "$report_file"
echo "Generated : $(date)" >> "$report_file"
echo "========================================" >> "$report_file"

# =====================================================
# Find Latest Backup
# =====================================================

latest_backup=$(ls -t "$backup_dir"/*.tar.gz 2>/dev/null | head -1)

# =====================================================
# Backup Exists Check
# =====================================================

if [ -z "$latest_backup" ]
then
    echo "[FAIL] No Backup Found" | tee -a "$report_file"
    exit 1
fi

echo "[PASS] Latest Backup Found: $latest_backup" \
| tee -a "$report_file"

# =====================================================
# File Size Check
# =====================================================

size=$(stat -c %s "$latest_backup")

if [ "$size" -gt 0 ]
then
    echo "[PASS] Backup Size Valid ($size bytes)" \
    | tee -a "$report_file"
else
    echo "[FAIL] Backup File Empty" \
    | tee -a "$report_file"

    status=1
fi

# =====================================================
# Archive Integrity Check
# =====================================================

tar -tzf "$latest_backup" >/dev/null 2>&1

if [ $? -eq 0 ]
then
    echo "[PASS] Archive Integrity Verified" \
    | tee -a "$report_file"
else
    echo "[FAIL] Corrupted Archive" \
    | tee -a "$report_file"

    status=1
fi

# =====================================================
# Final Result
# =====================================================

echo "========================================" \
>> "$report_file"

if [ "$status" -eq 0 ]
then
    echo "[PASS] Overall Status : SUCCESS" \
    | tee -a "$report_file"

    exit 0
else
    echo "[FAIL] Overall Status : FAILED" \
    | tee -a "$report_file"

    exit 1
fi