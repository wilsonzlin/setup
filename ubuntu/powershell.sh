#!/usr/bin/env bash

set -e

pushd "$(mktemp -d)" > /dev/null

sudo apt update
sudo apt install -y wget apt-transport-https software-properties-common
wget -q "https://packages.microsoft.com/config/ubuntu/$sl_lsb_release_version/packages-microsoft-prod.deb"
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update
sudo add-apt-repository universe
sudo apt install -y powershell

popd
