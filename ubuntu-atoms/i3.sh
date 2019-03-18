#!/usr/bin/env bash

set -e

pushd "$( mktemp -d )"

sudo /usr/lib/apt/apt-helper \
  download-file http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2018.01.30_all.deb \
  keyring.deb SHA256:baa43dbbd7232ea2b5444cae238d53bebb9d34601cc000e82f11111b1889078a
sudo dpkg -i ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $sl_lsb_release universe" | sudo tee -a /etc/apt/sources.list.d/sur5r-i3.list

sudo apt update
sudo apt install -y i3 i3status i3lock suckless-tools

popd
