#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to investigate
Jenkins pipeline failures.

What this script does:
1. Checks Jenkins service
2. Checks Java process
3. Checks disk space
4. Checks memory
5. Checks Docker
6. Checks Git connectivity
7. Generates audit report
=========================================================
COMMENT

echo "================================================="
echo " JENKINS PIPELINE AUDIT REPORT"
echo "================================================="

#########################################################
# Jenkins Service
#########################################################

echo ""
echo "Checking Jenkins Service..."

if systemctl is-active --quiet jenkins
then
    echo "✅ Jenkins Service Running"
else
    echo "❌ Jenkins Service Down"
fi

#########################################################
# Java Process
#########################################################

echo ""
echo "Checking Java Process..."

if pgrep java > /dev/null
then
    echo "✅ Java Process Running"
else
    echo "❌ Java Process Not Running"
fi

#########################################################
# Disk Usage
#########################################################

echo ""
echo "Checking Disk Usage..."

df -h /

#########################################################
# Memory Usage
#########################################################

echo ""
echo "Checking Memory..."

free -h

#########################################################
# Docker Status
#########################################################

echo ""
echo "Checking Docker..."

if systemctl is-active --quiet docker
then
    echo "✅ Docker Running"
else
    echo "❌ Docker Down"
fi

#########################################################
# Git Connectivity
#########################################################

echo ""
echo "Checking GitHub Connectivity..."

if git ls-remote https://github.com/git/git \
> /dev/null 2>&1
then
    echo "✅ GitHub Reachable"
else
    echo "❌ GitHub Unreachable"
fi

echo ""
echo "================================================="
echo " AUDIT COMPLETED"
echo "================================================="