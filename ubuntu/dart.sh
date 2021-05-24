#!/usr/bin/env bash

set -e

sudo apt-get install -y apt-transport-https
sudo sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'

sudo apt-get update
sudo apt-get install -y dart

echo 'export PATH="$PATH:/usr/lib/dart/bin"' >> "$HOME/.zshenv"
