#!/usr/bin/env bash

set -e

sudo apt-add-repository -y ppa:fish-shell/release-3
sudo apt update
sudo apt install -y fish
