#!/usr/bin/env bash

set -e

curl -sL "https://rpm.nodesource.com/setup_$sl_node_version.x" | sudo bash -

sudo dnf install -y gcc-c++ make nodejs
