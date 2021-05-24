#!/usr/bin/env bash

set -e

echo "deb http://www.apache.org/dist/cassandra/debian 36x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list

curl https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add -

sudo apt update

# Yes, this requires Python 2's pip.
sudo apt-get install -y cassandra python-pip

sudo systemctl --now disable cassandra

pip install cassandra-driver

echo 'export CQLSH_NO_BUNDLED=TRUE' >> "$HOME/.zshenv"
