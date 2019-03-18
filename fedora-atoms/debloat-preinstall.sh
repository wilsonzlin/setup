#!/usr/bin/env bash

set -e

# Purge unneeded packages
packages_to_remove="\
    gnome-software* \
    gnome-weather* \
    libreoffice* \
"

packages_to_remove_filtered=""

for pkg in $(echo $packages_to_remove); do
    sudo dnf list installed "$pkg" &> /dev/null
    if [ "$?" -eq 0 ]; then
        packages_to_remove_filtered="$packages_to_remove_filtered $pkg"
    fi
done

sudo dnf remove -y $packages_to_remove_filtered
