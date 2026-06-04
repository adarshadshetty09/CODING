#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to backup all
resources from a Kubernetes namespace.

What this script does:
1. Creates namespace backup
2. Exports all resources to YAML
3. Adds timestamp
4. Stores backup file
5. Helps disaster recovery
=========================================================
COMMENT

namespace="default"

backup_dir="/home/dopadm/k8s_backups"

mkdir -p "$backup_dir"

timestamp=$(date +"%Y%m%d_%H%M%S")

backup_file="${namespace}_backup_${timestamp}.yaml"

echo "Creating backup..."

kubectl get all -n "$namespace" -o yaml \
> "$backup_dir/$backup_file"

if [ $? -eq 0 ]
then
    echo "Backup successful"
    echo "File: $backup_dir/$backup_file"
else
    echo "Backup failed"
fi