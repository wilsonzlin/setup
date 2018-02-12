#!/usr/bin/env bash

set -e

# TLP
sudo add-apt-repository -y ppa:linrunner/tlp

sudo apt update

# Don't need tlp-rdw (plus it causes problems)
sudo apt install -y \
    tlp

# Configure TLP
sudo sed -i 's/^RESTORE_DEVICE_STATE_ON_STARTUP=.*$/RESTORE_DEVICE_STATE_ON_STARTUP=1/' /etc/default/tlp

exit 0
