#!/bin/bash

namespace="default"

backup_dir="/home/dopadm/k8s_backups"

mkdir -p "$backup_dir"

timestamp=$(date +"%Y%m%d_%H%M%S")

kubectl get deployment,svc,configmap,secret,ingress \
-n "$namespace" -o yaml \
> "$backup_dir/${namespace}_${timestamp}.yaml"

echo "Backup completed"