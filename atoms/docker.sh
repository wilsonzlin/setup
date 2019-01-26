#!/usr/bin/env bash

set -e

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $sl_lsb_release stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list

sudo apt update

sudo apt install -y docker-ce

sudo usermod -a -G docker "$USER"
