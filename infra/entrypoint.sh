#!/bin/bash
# sudo yum update -y && sudo yum install -y docker
# sudo systemctl start docker 
# sudo usermod -aG docker ec2-user
# docker run -p 8080:80 nginx

sudo yum update -y && sudo yum install -y docker
sudo yum install docker-compose-plugin
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

sudo systemctl start docker 
sudo usermod -aG docker ec2-user

aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 339713063029.dkr.ecr.eu-central-1.amazonaws.com/my-ecr-repo
docker pull 339713063029.dkr.ecr.eu-central-1.amazonaws.com/my-ecr-repo:119df5ad0ead2074036a31884d8f71e401275b30

docker compose up -d