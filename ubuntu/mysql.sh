#!/usr/bin/env bash

set -e

pushd "$( mktemp -d )"

# MySQL Workbench and Server
wget "$sl_mysql_apt_url" -O mysql-apt.deb
sudo dpkg -i mysql-apt.deb || true

sudo apt update

sudo apt install -y \
    mysql-server \
    mysql-workbench-community

# Set up MySQL databases
sudo mysql_secure_installation

# Prevent running automatically at startup
sudo systemctl disable mysql.service

popd
