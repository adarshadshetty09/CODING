#!/bin/bash

source_dir="yugabytedb-cloud-automation-gcp"
backup_dir="/home/dopadm/backups"

timestamp=$(date +"%Y%m%d_%H%M%S")

backup_file="yugabytedb-cloud-automation-gcp_${timestamp}.tar.gz"

mkdir -p "$backup_dir"

tar -czf "$backup_dir/$backup_file" "$source_dir"

if [ $? -eq 0 ]
then
    echo "Backup completed successfully"
    echo "$backup_dir/$backup_file"
else
    echo "Backup failed"
fi