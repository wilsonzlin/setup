#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"

sudo add-apt-repository -y ppa:linrunner/tlp
sudo apt-get update -y

sudo apt install -y tlp tlp-rdw
sudo cp /etc/default/tlp /etc/default/tlp.original
sudo cp basic-tlp.conf /etc/default/tlp

exit 0
