#!/usr/bin/env bash

set -e

sudo apt update
sudo apt dist-upgrade -y
sudo apt install -y curl software-properties-common wget

sl_lsb_release="$(lsb_release -s -c)"
if [ "$sl_lsb_release" == "serena" ] || [ "$sl_lsb_release" == "sonya" ] ; then
    sl_lsb_release="xenial"
fi
export sl_lsb_release

exit 0
