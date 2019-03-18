#!/usr/bin/env bash

set -e

sudo apt update
sudo apt dist-upgrade -y
sudo apt install -y curl wget software-properties-common snapd

exit 0
