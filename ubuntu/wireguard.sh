#!/usr/bin/env bash

set -e

sudo add-apt-repository -y ppa:wireguard/wireguard
sudo apt update
sudo apt install -y wireguard
