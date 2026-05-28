#!/bin/bash 

service="nginx"

if systemctl is-active --quite "$service"
then 
    echo "$service service is running"
else
    echo "$service service is down"
    echo "Attempting to restart..."

    sudo systemctl restart "$service"

    if systemctl is-active --quite "$service"
    then
        echo "$service restarted successfully"
    else
        echo "Failed to restart $service"
    fi 
fi