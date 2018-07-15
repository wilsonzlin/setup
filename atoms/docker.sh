#!/usr/bin/env bash

set -e

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $sl_lsb_release \
   stable"

sudo apt update

sudo apt install docker-ce

sudo usermod -a -G docker "$USER"
