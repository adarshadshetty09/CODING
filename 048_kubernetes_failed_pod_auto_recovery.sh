#!/bin/bash

namespaces=(
"default"
"monitoring"
"ingress-nginx"
)

for ns in "${namespaces[@]}"
do
    echo ""
    echo "Checking Namespace: $ns"

    kubectl get pods -n "$ns" --no-headers | \
    while read pod ready status rest
    do
        if [[ "$status" == "CrashLoopBackOff" || \
              "$status" == "Error" || \
              "$status" == "ImagePullBackOff" ]]
        then
            echo "Recovering $pod"

            kubectl delete pod "$pod" -n "$ns"
        fi
    done
done