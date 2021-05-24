#!/usr/bin/env bash

set -e

sudo add-apt-repository -y ppa:nginx/stable

sudo apt update

sudo apt install -y nginx

# Disable service; it can be enabled as necessary and might conflict with other HTTP servers on default settings.
sudo systemctl --now disable nginx
