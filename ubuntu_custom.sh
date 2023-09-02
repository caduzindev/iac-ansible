#!/bin/bash
docker build --build-arg SUDO_PASSWORD=carlos -t ubuntu_custom .
docker run -d -p "2222:22" -p "8000:80" -p "3333:3306" ubuntu_custom

#generate sshkeys
ssh-keygen -f ~/sshkey -t rsa -b 4096