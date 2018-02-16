#!/usr/bin/env bash

set -e

sudo apt update
sudo apt dist-upgrade -y
sudo apt install -y curl software-properties-common wget

exit 0
