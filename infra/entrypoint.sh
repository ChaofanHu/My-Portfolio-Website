#!/bin/bash

sudo yum update -y       
sudo yum install git -y   
sudo yum install nom -y
mkdir MyWeb


REPO_URL="https://github.com/ChaofanHu/My-Portfolio-Website.git"

if [ ! -d "$CLONE_DIR" ]; then
    mkdir -p "$CLONE_DIR"
fi

git clone $REPO_URL $CLONE_DIR

cd $CLONE_DIR

npm install
npm start

