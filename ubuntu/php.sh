#!/usr/bin/env bash

set -e

sudo add-apt-repository -y ppa:ondrej/php

sudo apt install -y php7.4

# php7.4 installs apache2 automatically, so disable it; it's unnecessary and might conflict with other HTTP servers.
sudo systemctl --now disable apache2
