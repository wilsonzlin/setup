#!/usr/bin/env bash

set -e

sudo apt install -y \
  python3-pip \
  fonts-powerline

pip3 install --user powerline-shell
