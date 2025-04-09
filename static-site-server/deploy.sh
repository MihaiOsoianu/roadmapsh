#!/bin/bash

local_dir=<your-value>
user=<your-value>
remote_server=<your-value>
remote_path=<your-value>
private_key=<your-value>

echo "Starting deployment"

rsync -avz -e "ssh -i $private_key" "$local_dir/" "$user@$remote_server:$remote_path"

if [ $? -ne 0 ]; then
	echo "rsync failed. Deployment aborted."
	exit 1
fi

ssh -i "$private_key" "$user@$remote_server" "sudo systemctl restart nginx"
if [ $? -ne 0 ]; then
	echo "Failed to restart nginx on remote server."
	exit 1
fi

echo "Deployment completed!"
