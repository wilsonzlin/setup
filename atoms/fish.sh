#!/usr/bin/env bash

set -e

sudo apt-add-repository -y ppa:fish-shell/release-2
sudo apt update
sudo apt install -y fish

chsh -s `which fish`
