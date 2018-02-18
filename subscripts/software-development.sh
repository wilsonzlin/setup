#!/usr/bin/env bash

set -e

pushd "$( mktemp -d )"

# Node.js
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

sudo apt install -y \
    build-essential \
    default-jdk \
    git \
    make \
    maven \
    nodejs \
    sqlite3 \
    python2.7 \
    python-pip \
    python3-pip \
    lua5.1 \
    vim

wget "https://go.microsoft.com/fwlink/?LinkID=760868" -O vscode.deb
sudo dpkg -i vscode.deb || true

sudo apt install -y -f

popd

exit 0
