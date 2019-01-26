#!/usr/bin/env bash

set -e

wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add -

sudo add-apt-repository -y 'deb https://repo.vivaldi.com/archive/deb/ stable main'

sudo apt update
sudo apt install -y vivaldi-stable
