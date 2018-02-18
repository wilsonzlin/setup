#!/usr/bin/env bash

set -e

# TLP
sudo add-apt-repository -y ppa:linrunner/tlp

sudo apt update

# Don't need tlp-rdw (plus it causes problems)
# tlp installs postfix, so don't install recommendations
sudo apt install --no-install-recommends -y \
    tlp \
    linux-tools-generic \
    linux-tools-common

# Configure TLP
sudo sed -i 's/^RESTORE_DEVICE_STATE_ON_STARTUP=.*$/RESTORE_DEVICE_STATE_ON_STARTUP=1/' /etc/default/tlp

exit 0
