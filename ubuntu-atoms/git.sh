#!/usr/bin/env bash

set -e

curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash

sudo apt install -y git git-lfs
