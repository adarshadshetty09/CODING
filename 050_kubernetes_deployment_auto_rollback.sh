#!/bin/bash

namespace="default"

deployments=(
"frontend"
"backend"
"redis"
)

for deployment in "${deployments[@]}"
do
    echo ""
    echo "Checking Deployment: $deployment"

    if kubectl rollout status deployment "$deployment" \
    -n "$namespace" --timeout=60s
    then
        echo "SUCCESS"
    else
        echo "FAILED"
        echo "Rolling back..."

        kubectl rollout undo deployment "$deployment" \
        -n "$namespace"

        echo "Rollback completed"
    fi

    echo "-------------------------------------"
done