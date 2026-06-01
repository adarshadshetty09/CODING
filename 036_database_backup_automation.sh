#!/bin/bash

<<COMMENT
=========================================================
Question:
Write a shell script to automate MySQL
database backups.

What this script does:
1. Creates MySQL database backup
2. Adds timestamp to backup file
3. Verifies backup success
4. Removes backups older than 7 days
=========================================================
COMMENT

# Database Details
db_name="mydb"
db_user="root"
db_password="password"

# Backup Directory
backup_dir="/home/dopadm/db_backups"

mkdir -p "$backup_dir"

# Timestamp
timestamp=$(date +"%Y%m%d_%H%M%S")

# Backup File
backup_file="${db_name}_${timestamp}.sql"

# Create Backup
mysqldump -u "$db_user" -p"$db_password" \
"$db_name" > "$backup_dir/$backup_file"

# Verify Backup
if [ $? -eq 0 ]
then
    echo "Database backup completed successfully"
    echo "Backup File: $backup_dir/$backup_file"
else
    echo "Database backup failed"
    exit 1
fi

# Delete backups older than 7 days
find "$backup_dir" -type f -name "*.sql" -mtime +7 -delete

echo "Old backups cleaned up"