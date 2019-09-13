#!/usr/bin/env bash

set -e

sudo dnf install -y \
    tlp \
    tlp-rdw

# Configure TLP
sudo sed -i 's/^RESTORE_DEVICE_STATE_ON_STARTUP=.*$/RESTORE_DEVICE_STATE_ON_STARTUP=1/' /etc/default/tlp
# Don't suspend Bluetooth as this breaks Bluetooth support
sudo sed -i 's/^USB_BLACKLIST_BTUSB=.*$/USB_BLACKLIST_BTUSB=1/' /etc/default/tlp
