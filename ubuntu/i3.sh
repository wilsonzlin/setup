#!/usr/bin/env bash

set -e

pushd "$( mktemp -d )"

/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2021.02.02_all.deb keyring.deb SHA256:cccfb1dd7d6b1b6a137bb96ea5b5eef18a0a4a6df1d6c0c37832025d2edaa710
sudo dpkg -i ./keyring.deb
echo "deb [arch=amd64] http://debian.sur5r.net/i3/ $sl_lsb_release universe" | sudo tee -a /etc/apt/sources.list.d/sur5r-i3.list

sudo apt update
sudo apt install -y i3 i3status i3lock suckless-tools

popd
