#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to perform pre-deployment
validation checks before deploying an application.

Purpose:
Ensure that the target server is healthy and
ready for deployment.

What this script does:
1. Checks disk usage
2. Checks memory usage
3. Checks CPU load
4. Verifies Docker service
5. Verifies Kubernetes cluster connectivity
6. Checks internet connectivity
7. Verifies required ports are listening
8. Displays deployment readiness status

Prerequisites:
- Docker installed
- kubectl configured
- Linux server

Expected Output:
[PASS] Disk Usage
[PASS] Memory Usage
[PASS] CPU Load
[PASS] Docker
[PASS] Kubernetes
[PASS] Internet Connectivity
[PASS] Port 80

Overall Status : PASSED

=========================================================
COMMENT

# =====================================================
# Configuration
# =====================================================

disk_threshold=80
memory_threshold=85
cpu_threshold=5

required_ports=(80 443)

overall_status=0

# =====================================================
# Function: Check Disk Usage
# =====================================================

check_disk_usage()
{
    usage=$(df / | awk 'NR==2 {gsub("%","",$5); print $5}')

    if [ "$usage" -lt "$disk_threshold" ]
    then
        echo "[PASS] Disk Usage : ${usage}%"
    else
        echo "[FAIL] Disk Usage : ${usage}%"
        overall_status=1
    fi
}

# =====================================================
# Function: Check Memory Usage
# =====================================================

check_memory_usage()
{
    usage=$(free | awk '/Mem/ {printf("%.0f",$3/$2*100)}')

    if [ "$usage" -lt "$memory_threshold" ]
    then
        echo "[PASS] Memory Usage : ${usage}%"
    else
        echo "[FAIL] Memory Usage : ${usage}%"
        overall_status=1
    fi
}

# =====================================================
# Function: Check CPU Load
# =====================================================

check_cpu_load()
{
    load=$(uptime | awk -F'load average:' '{print $2}' | cut -d',' -f1 | xargs)

    load_int=$(echo "$load" | cut -d'.' -f1)

    if [ "$load_int" -lt "$cpu_threshold" ]
    then
        echo "[PASS] CPU Load : $load"
    else
        echo "[FAIL] CPU Load : $load"
        overall_status=1
    fi
}

# =====================================================
# Function: Check Docker
# =====================================================

check_docker()
{
    if systemctl is-active --quiet docker
    then
        echo "[PASS] Docker Service"
    else
        echo "[FAIL] Docker Service"
        overall_status=1
    fi
}

# =====================================================
# Function: Check Kubernetes Connectivity
# =====================================================

check_kubernetes()
{
    kubectl cluster-info >/dev/null 2>&1

    if [ $? -eq 0 ]
    then
        echo "[PASS] Kubernetes Cluster"
    else
        echo "[FAIL] Kubernetes Cluster"
        overall_status=1
    fi
}

# =====================================================
# Function: Check Internet Connectivity
# =====================================================

check_internet()
{
    ping -c 2 google.com >/dev/null 2>&1

    if [ $? -eq 0 ]
    then
        echo "[PASS] Internet Connectivity"
    else
        echo "[FAIL] Internet Connectivity"
        overall_status=1
    fi
}

# =====================================================
# Function: Check Required Ports
# =====================================================

check_ports()
{
    for port in "${required_ports[@]}"
    do
        if ss -tuln | grep -q ":$port "
        then
            echo "[PASS] Port $port Listening"
        else
            echo "[FAIL] Port $port Not Listening"
            overall_status=1
        fi
    done
}

# =====================================================
# Main Function
# =====================================================

main()
{
    echo "==========================================="
    echo "      PRE-DEPLOYMENT VALIDATION REPORT"
    echo "==========================================="

    echo
    check_disk_usage
    check_memory_usage
    check_cpu_load
    check_docker
    check_kubernetes
    check_internet
    check_ports

    echo
    echo "==========================================="

    if [ "$overall_status" -eq 0 ]
    then
        echo "Overall Status : PASSED"
        exit 0
    else
        echo "Overall Status : FAILED"
        exit 1
    fi
}

main