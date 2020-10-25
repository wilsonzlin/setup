#!/usr/bin/env bash

set -e

sudo apt install -y docker.io

sudo usermod -a -G docker "$USER"

# This URL will redirect, so make sure to follow redirects.
wget "$sl_docker_compose_url" -O "$HOME/Applications/docker-compose"
chmod +x "$HOME/Applications/docker-compose"
ln -s "$HOME/Applications/docker-compose" "$HOME/bin/"

if command -v nvidia-smi &> /dev/null; then
  distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
  curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
  curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
  sudo apt update
  sudo apt install -y nvidia-docker2
fi
