#!/usr/bin/env bash

set -e

curl -sL "https://deb.nodesource.com/setup_$sl_node_version.x" | sudo -E bash -

sudo apt install -y build-essential nodejs

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash
