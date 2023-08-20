#!/bin/bash

a=$(aws ec2 describe-instances --region ap-south-1 --filters "Name=tag:Name,Values=MMK" --query "Reservations[].Instances[].PublicIpAddress" --output text )

echo "$a"

ssh -o StrictHostKeyChecking=no -i "$SSH_KEY" "$ubuntu"@"$a"<<EOF

sudo docker-compose  up -d

sleep 4

if curl localhost:80
then
  echo "SUCCESSFULLY DEPLOYED"
fi


EOF