#!/usr/bin/env bash

set -e

wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
echo 'deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main' | sudo tee /etc/apt/sources.list.d/atom.list
sudo apt update
sudo apt install -y atom
