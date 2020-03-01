#!/usr/bin/env bash

set -e

sudo add-apt-repository -y ppa:linrunner/tlp

sudo apt update

# Don't need tlp-rdw (plus it causes problems)
# tlp installs postfix, so don't install recommendations
sudo apt install --no-install-recommends -y \
    tlp \
    linux-tools-generic \
    linux-tools-common

if [ -f "/etc/default/tlp" ]; then
  tlp_conf="/etc/default/tlp"
elif [ -f "/etc/tlp.conf" ]; then
  tlp_conf="/etc/tlp.conf"
else
  echo "Cannot find TLP configuration file"
  exit 1
fi

# Configure TLP
sudo sed -i 's/^RESTORE_DEVICE_STATE_ON_STARTUP=.*$/RESTORE_DEVICE_STATE_ON_STARTUP=1/' "$tlp_conf"
# Don't suspend Bluetooth as this breaks Bluetooth support
sudo sed -i 's/^USB_BLACKLIST_BTUSB=.*$/USB_BLACKLIST_BTUSB=1/' "$tlp_conf"
