#!/bin/sh

# add source
cat /dev/null | sudo tee /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse                 " | sudo tee -a /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse        " | sudo tee -a /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse         " | sudo tee -a /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse        " | sudo tee -a /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse       " | sudo tee -a /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse             " | sudo tee -a /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse    " | sudo tee -a /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse     " | sudo tee -a /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse    " | sudo tee -a /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse   " | sudo tee -a /etc/apt/sources.list

sudo apt-get update -y
sudo apt-get upgrade -y

# docker ce
sudo apt remove docker docker-engine docker.io -y
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update -y
sudo apt install docker-ce -y

# add docker to current user group
sudo groupadd docker
#sudo usermod -aG docker $USER
sudo gpasswd -a ${USER} docker
sudo systemctl enable docker
echo "{\"registry-mirrors\":[\"https://registry.docker-cn.com\"]}" | sudo tee -a /etc/docker/daemon.json
sudo systemctl daemon-reload
sudo systemctl restart docker

#docker-compose install 
sudo curl -L https://github.com/docker/compose/releases/download/1.26.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


