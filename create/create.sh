#!/bin/bash

#Create  instance infrastructure 

terraform init && terraform "${option}" --auto-approve

sleep 5

# to get public IP and store the variable 
a=$(aws ec2 describe-instances --region ap-south-1 --filters "Name=tag:Name,Values=MMK" --query "Reservations[].Instances[].PublicIpAddress" --output text )

b=$(aws ec2 describe-instances --region ap-south-1 --filters "Name=tag:Name,Values=MUTHU" --query "Reservations[].Instances[].PublicIpAddress" --output text )

echo "$a"
echo "$b"

echo "Terraform Exceute Successfully"
sleep 5

# login the ssh-remote server & put the variable instead of public ip
scp -o StrictHostKeyChecking=no -i "$SSH_KEY" docker-compose.yml "$ubuntu"@$a:/home/ubuntu
ssh -o StrictHostKeyChecking=no -i "$SSH_KEY" "$ubuntu"@$a<<EOF

ls

sudo apt-get update -y
sudo apt-get install docker.io -y
sudo apt-get install docker-compose -y

sudo systemctl start docker
EOF
