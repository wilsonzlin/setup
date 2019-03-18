#!/usr/bin/env bash

set -e

curl -sL "https://deb.nodesource.com/setup_$sl_node_version.x" | sudo -E bash -

sudo apt install -y build-essential nodejs
