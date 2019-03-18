#!/usr/bin/env bash

set -e

sudo tee /etc/yum.repos.d/virtualbox.repo << 'EOM'
[virtualbox]
name=Fedora $releasever - $basearch - VirtualBox
baseurl=http://download.virtualbox.org/virtualbox/rpm/fedora/$releasever/$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.virtualbox.org/download/oracle_vbox.asc
EOM

sudo dnf install -y binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms qt5-qtx11extras libxkbcommon
sudo dnf check-update
sudo dnf install -y VirtualBox-6.0

VBOX_VERSION=$(vboxmanage -v)
VBOX_VERSION_POINT=$(echo $VBOX_VERSION | cut -d 'r' -f 1)
VBOX_VERSION_BUILD=$(echo $VBOX_VERSION | cut -d 'r' -f 2)
VBOX_EXTPACK_FILENAME="Oracle_VM_VirtualBox_Extension_Pack-$VBOX_VERSION_POINT-$VBOX_VERSION_BUILD.vbox-extpack"
wget http://download.virtualbox.org/virtualbox/$VBOX_VERSION_POINT/$VBOX_EXTPACK_FILENAME
echo y | sudo VBoxManage extpack install $VBOX_EXTPACK_FILENAME --replace

sudo usermod -a -G vboxusers "$USER"

popd
