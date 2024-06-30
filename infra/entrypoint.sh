#!/bin/bash

sudo yum update -y

sudo yum install git -y

curl -fsSL https://rpm.nodesource.com/setup_16.x | sudo bash -

sudo yum install -y nodejs

REPO_URL="https://github.com/ChaofanHu/My-Portfolio-Website.git"

git clone $REPO_URL

cd /My-Portfolio-Website

npm install

npm start 

# sudo amazon-linux-extras install nginx1 -y

# sudo systemctl enable nginx
# sudo systemctl start nginx

# sudo tee /etc/nginx/conf.d/my_website.conf > /dev/null <<EOT
# server {
#     listen 80;
#     server_name _;

#     location / {
#         proxy_pass http://localhost:3000;
#         proxy_set_header Host \$host;
#         proxy_set_header X-Real-IP \$remote_addr;
#         proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
#         proxy_set_header X-Forwarded-Proto \$scheme;
#     }
# }

# server {
#     listen 443 ssl;
#     server_name _;

#     ssl_certificate /etc/nginx/ssl/nginx.crt;
#     ssl_certificate_key /etc/nginx/ssl/nginx.key;

#     location / {
#         proxy_pass http://localhost:3000;
#         proxy_set_header Host \$host;
#         proxy_set_header X-Real-IP \$remote_addr;
#         proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
#         proxy_set_header X-Forwarded-Proto \$scheme;
#     }
# }
# EOT

# sudo mkdir -p /etc/nginx/ssl
# sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/CN=localhost"

# sudo systemctl restart nginx