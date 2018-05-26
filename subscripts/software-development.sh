#!/usr/bin/env bash

set -e

pushd "$( mktemp -d )"

# Node.js
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -

# VS Code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt update

sudo apt install -y \
    git \
    nodejs \
    code

popd

exit 0
