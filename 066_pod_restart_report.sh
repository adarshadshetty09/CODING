#!/bin/bash

threshold=5

for ns in $(kubectl get ns --no-headers -o custom-columns=":metadata.name")
do
    echo ""
    echo "Namespace: $ns"
    echo "--------------------------------------------------"

    kubectl get pods -n "$ns" --no-headers 2>/dev/null | \
    while read pod ready status restarts age
    do
        if [ "$restarts" -gt "$threshold" ]
        then
            echo "$pod : $restarts Restarts ($status)"
        fi
    done
done
