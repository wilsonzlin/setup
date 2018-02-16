#!/usr/bin/env bash

set -e

# Tune Linux networking
echo 'net.ipv4.ip_local_port_range = 1024 65535' | sudo tee -a /etc/sysctl.conf
echo 'net.core.somaxconn = 4096' | sudo tee -a /etc/sysctl.conf

# Enable firewall
sudo ufw enable

exit 0
