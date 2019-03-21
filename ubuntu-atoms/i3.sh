#!/usr/bin/env bash

set -e

pushd "$( mktemp -d )"

/usr/lib/apt/apt-helper download-file http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2019.02.01_all.deb keyring.deb SHA256:176af52de1a976f103f9809920d80d02411ac5e763f695327de9fa6aff23f416
sudo dpkg -i ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $sl_lsb_release universe" | sudo tee -a /etc/apt/sources.list.d/sur5r-i3.list

sudo apt update
sudo apt install -y i3 i3status i3lock suckless-tools

popd
