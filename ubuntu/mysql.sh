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

# Configure MySQL service
sudo mkdir -p /etc/systemd/system/mysql.service.d/
echo '[Service]' | sudo tee /etc/systemd/system/mysql.service.d/override.conf
echo 'LimitNOFILE=infinity' | sudo tee -a /etc/systemd/system/mysql.service.d/override.conf

# Tune MySQL
sudo sed -i '/^skip-external-locking$/a sql-mode = "STRICT_ALL_TABLES,ONLY_FULL_GROUP_BY,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i 's/^max_allowed_packet.*/max_allowed_packet = 4096M/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i 's/^thread_stack.*/thread_stack = 256K/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i 's/^#max_connections.*/max_connections = 1000000/' /etc/mysql/mysql.conf.d/mysqld.cnf

# Prevent running automatically at startup
sudo systemctl disable mysql.service

popd
