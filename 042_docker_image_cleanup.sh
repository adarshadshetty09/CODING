#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to clean up unused
Docker resources.

What this script does:
1. Removes dangling images
2. Removes stopped containers
3. Removes unused volumes
4. Frees disk space
5. Generates cleanup report
=========================================================
COMMENT

echo "================================="
echo " DOCKER CLEANUP REPORT"
echo "================================="

echo ""
echo "Removing stopped containers..."
docker container prune -f

echo ""
echo "Removing dangling images..."
docker image prune -f

echo ""
echo "Removing unused volumes..."
docker volume prune -f

echo ""
echo "Removing unused networks..."
docker network prune -f

echo ""
echo "================================="
echo " DOCKER CLEANUP COMPLETED"
echo "================================="