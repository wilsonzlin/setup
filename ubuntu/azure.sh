#!/usr/bin/env bash

set -e

echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $sl_lsb_release main" | \
    sudo tee /etc/apt/sources.list.d/azure-cli.list

curl -L https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

sudo apt update
sudo apt install -y azure-cli
