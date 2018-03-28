#!/usr/bin/env bash

set -e

pushd "$( mktemp -d )"

# Node.js
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $sl_lsb_release \
   stable"
sudo apt update

sudo apt install -y \
    build-essential \
    docker-ce \
    git \
    make \
    nodejs \
    python2.7 \
    python-pip \
    python-3 \
    python3-pip

wget "https://go.microsoft.com/fwlink/?LinkID=760868" -O vscode.deb
sudo dpkg -i vscode.deb || true

sudo apt install -y -f

popd

exit 0
