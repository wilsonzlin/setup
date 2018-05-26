#!/usr/bin/env bash

set -e

pushd "$( mktemp -d )"

# Node.js
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $sl_lsb_release \
   stable"

# VS Code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt update

sudo apt install -y \
    docker-ce \
    git \
    nodejs \
    code

popd

exit 0
