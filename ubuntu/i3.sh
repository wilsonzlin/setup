#!/usr/bin/env bash

set -e

pushd "$( mktemp -d )"

/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2020.02.03_all.deb keyring.deb SHA256:c5dd35231930e3c8d6a9d9539c846023fe1a08e4b073ef0d2833acd815d80d48
sudo dpkg -i ./keyring.deb
echo "deb [arch=amd64] http://debian.sur5r.net/i3/ $sl_lsb_release universe" | sudo tee -a /etc/apt/sources.list.d/sur5r-i3.list

sudo apt update
sudo apt install -y i3 i3status i3lock suckless-tools

popd
