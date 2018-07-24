#!/usr/bin/env bash

set -e

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ ${sl_lsb_release}-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt update
sudo apt install -y pgadmin4
