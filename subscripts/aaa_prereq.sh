#!/usr/bin/env bash

set -e

sudo apt update
sudo apt dist-upgrade -y
sudo apt install -y curl software-properties-common wget \
  apt-transport-https ca-certificates # These are for Docker

exit 0
