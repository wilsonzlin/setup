#!/usr/bin/env bash

set -e

wget -O- https://apt.corretto.aws/corretto.key | sudo apt-key add -
sudo add-apt-repository 'deb https://apt.corretto.aws stable main'

sudo apt update
sudo apt install -y java-16-amazon-corretto-jdk
