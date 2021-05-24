#!/usr/bin/env bash

set -e

pushd "$( mktemp -d )"

echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $sl_lsb_release contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.sources.list
curl -L https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo apt-key add -

sudo apt update

sudo apt install -y virtualbox-6.0 dkms

VBOX_VERSION=$(vboxmanage -v)
VBOX_VERSION_POINT=$(echo "$VBOX_VERSION" | cut -d 'r' -f 1)
VBOX_VERSION_BUILD=$(echo "$VBOX_VERSION" | cut -d 'r' -f 2)
VBOX_EXTPACK_FILENAME="Oracle_VM_VirtualBox_Extension_Pack-$VBOX_VERSION_POINT-$VBOX_VERSION_BUILD.vbox-extpack"
wget "http://download.virtualbox.org/virtualbox/$VBOX_VERSION_POINT/$VBOX_EXTPACK_FILENAME"
sudo VBoxManage extpack install "$VBOX_EXTPACK_FILENAME" --replace <<< 'y'

sudo usermod -a -G vboxusers "$USER"

popd
