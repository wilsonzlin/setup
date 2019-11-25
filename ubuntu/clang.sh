#!/usr/bin/env bash

set -e

sudo apt install -y clang-7 lld-7

sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-7 100
sudo update-alternatives --install /usr/bin/lld lld /usr/bin/lld-7 100
