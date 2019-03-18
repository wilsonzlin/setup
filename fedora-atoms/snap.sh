#!/usr/bin/env bash

set -e

# NOTE: On Fedora 29, snapd won't work until reboot, so it can't be used to install anything in setup-linux
sudo dnf install -y snapd
