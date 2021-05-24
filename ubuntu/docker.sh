#!/usr/bin/env bash

set -e

# Official docs suggest using their repo over standard repo's legacy docker.io package.
# However, more recent advice for docker.io suggest it's better as it's now kept up to date, and more modular and compact.
# However however, docker.io installation doesn't work as reliably, with conflicting/mismatched dependency versions.
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $sl_lsb_release stable" | sudo tee /etc/apt/sources.list.d/docker.list

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

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
