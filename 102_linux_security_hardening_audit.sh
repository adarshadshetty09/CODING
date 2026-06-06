#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to perform a Linux
Security Hardening Audit.

Scenario:
An external security audit is scheduled
in two weeks.

The company recently failed a compliance
review because several Linux servers had:

- Root SSH login enabled
- Password authentication enabled
- Unused privileged accounts
- World-writable files
- Weak sudo controls

Management has requested a full security
assessment before the auditors arrive.

The Linux and DevOps teams must identify
security weaknesses and generate a report.

Purpose:
Identify Linux security risks and improve
compliance posture before audits.

What this script does:
1. Checks SSH root login
2. Checks password authentication
3. Finds UID 0 accounts
4. Finds empty password accounts
5. Finds world-writable files
6. Reviews sudo access
7. Generates security compliance report

Prerequisites:
- Linux server
- Root or sudo access
- grep, awk, find commands available

Expected Output:
linux_security_audit_report.txt

Security Status:
COMPLIANT / NON-COMPLIANT

Real-world Use Case:
Used by Linux Administrators, Security
Teams, DevOps Engineers and Auditors
during compliance assessments.

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

report_file="linux_security_audit_report.txt"

status=0

# =====================================================
# Report Header
# =====================================================

{
echo "========================================="
echo " LINUX SECURITY HARDENING AUDIT"
echo "========================================="
echo "Generated: $(date)"
echo
} > "$report_file"

# =====================================================
# Root SSH Login Check
# =====================================================

root_login=$(grep "^PermitRootLogin" \
/etc/ssh/sshd_config 2>/dev/null | awk '{print $2}')

if [ "$root_login" = "no" ]
then
    echo "[PASS] Root SSH Login Disabled" \
    >> "$report_file"
else
    echo "[FAIL] Root SSH Login Enabled" \
    >> "$report_file"

    status=1
fi

# =====================================================
# Password Authentication Check
# =====================================================

password_auth=$(grep "^PasswordAuthentication" \
/etc/ssh/sshd_config 2>/dev/null | awk '{print $2}')

if [ "$password_auth" = "no" ]
then
    echo "[PASS] Password Authentication Disabled" \
    >> "$report_file"
else
    echo "[FAIL] Password Authentication Enabled" \
    >> "$report_file"

    status=1
fi

# =====================================================
# UID 0 Accounts
# =====================================================

{
echo
echo "===== UID 0 ACCOUNTS ====="
awk -F: '$3==0 {print $1}' /etc/passwd
} >> "$report_file"

uid_zero_count=$(awk -F: '$3==0 {print $1}' \
/etc/passwd | wc -l)

if [ "$uid_zero_count" -gt 1 ]
then
    status=1
fi

# =====================================================
# Empty Password Accounts
# =====================================================

{
echo
echo "===== EMPTY PASSWORD ACCOUNTS ====="
awk -F: '($2==""){print $1}' /etc/shadow \
2>/dev/null
} >> "$report_file"

# =====================================================
# World Writable Files
# =====================================================

{
echo
echo "===== WORLD WRITABLE FILES ====="
find / -type f -perm -0002 2>/dev/null | head -20
} >> "$report_file"

# =====================================================
# Sudo Access Review
# =====================================================

{
echo
echo "===== SUDO USERS ====="
getent group sudo
getent group wheel
} >> "$report_file"

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
    echo "SECURITY STATUS : COMPLIANT"
    echo "No critical findings detected."
    } >> "$report_file"
else
    {
    echo "SECURITY STATUS : NON-COMPLIANT"
    echo "Review findings immediately."
    } >> "$report_file"
fi

# =====================================================
# Completion
# =====================================================

echo
echo "Linux Security Audit Complete"
echo "Report Generated:"
echo "$report_file"

if [ "$status" -eq 0 ]
then
    echo "SECURITY STATUS : COMPLIANT"
else
    echo "SECURITY STATUS : NON-COMPLIANT"
fi