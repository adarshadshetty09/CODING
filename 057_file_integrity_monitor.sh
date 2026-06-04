#!/bin/bash

<<COMMENT
=========================================================
Question:
Monitor multiple critical system files
for unauthorized changes.

What this script does:
1. Monitors multiple files
2. Compares SHA256 checksums
3. Detects file changes
4. Generates security report
=========================================================
COMMENT

files=(
"/etc/passwd"
"/etc/hosts"
"/etc/group"
)

for file in "${files[@]}"
do
    checksum_file=$(basename "$file").sha256

    if [ ! -f "$checksum_file" ]
    then
        sha256sum "$file" > "$checksum_file"

        echo "Baseline created for $file"
        continue
    fi

    current=$(sha256sum "$file" | awk '{print $1}')
    stored=$(awk '{print $1}' "$checksum_file")

    if [ "$current" = "$stored" ]
    then
        echo "✅ $file : OK"
    else
        echo "❌ $file : MODIFIED"
    fi
done