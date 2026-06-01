#!/bin/bash

<<COMMENT
=========================================================
Question:
Perform complete Docker cleanup.

What this script does:
1. Removes stopped containers
2. Removes unused images
3. Removes unused volumes
4. Removes unused networks
5. Frees maximum disk space
=========================================================
COMMENT

echo "Docker Disk Usage Before Cleanup"
docker system df

echo ""
echo "Starting cleanup..."

docker system prune -a -f --volumes

echo ""
echo "Docker Disk Usage After Cleanup"
docker system df