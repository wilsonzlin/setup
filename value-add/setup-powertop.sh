#!/usr/bin/env bash

set -e

sudo apt install powertop
sudo sed -i '/^exit 0$/i \
powertop --auto-tune &\
' /etc/rc.local

exit 0
