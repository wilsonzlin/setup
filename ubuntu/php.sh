#!/usr/bin/env bash

set -e

sudo add-apt-repository -y ppa:ondrej/php

sudo apt install -y php8.0

# php8.0 installs apache2.
sudo systemctl --now disable apache2
