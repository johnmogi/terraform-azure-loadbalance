#!/bin/bash
apt update -y
apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \ 
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"
apt install docker-ce -y
docker pull postgres:latest -y
docker run -d  --restart=unless-stopped --name measurements -p 5432:5432 -e 'POSTGRES_PASSWORD=p@ssw0rd42' postgres


# add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y