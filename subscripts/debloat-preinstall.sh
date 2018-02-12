#!/usr/bin/env bash

set -e

# Purge unneeded packages
# Purging libreoffice* will break Linux Mint's UI
packages_to_remove="\
    abiword* \
    audacious* \
    brasero* \
    btrfs-tools \
    eog* \
    gedit* \
    gnome-calendar* \
    gnome-mplayer* \
    gnome-orca* \
    gnome-software* \
    gnome-user-share \
    gnumeric* \
    gpicview* \
    gufw* \
    guvcview* \
    hexchat* \
    leafpad* \
    libreoffice-common \
    lubuntu-software-center \
    mintbackup* \
    mintinstall* \
    mintnanny* \
    mintupdate* \
    mintupload* \
    mintwelcome* \
    mplayer* \
    mtpaint* \
    nautilus-share* \
    pidgin* \
    pix* \
    remmina* \
    *rhythmbox* \
    shotwell* \
    simple-scan* \
    sylpheed* \
    thunderbird* \
    tomboy* \
    *totem* \
    transmission* \
    ubuntu-software* \
    unity-webapps* \
    update-notifier \
    vino* \
    virtualbox-guest* \
    webapp-container* \
    webbrowser-app* \
    xed* \
    xfburn* \
    xpad \
    xplayer* \
    xviewer* \
"

packages_to_remove_filtered=""

for pkg in $(echo $packages_to_remove); do
    output="$(sudo apt list --installed "$pkg" | wc -l)"
    if [ "$output" -gt 1 ]; then
        packages_to_remove_filtered="$packages_to_remove_filtered $pkg"
    fi
done

sudo apt purge -y $packages_to_remove_filtered

sudo apt autoremove -y

# Disable unneeded services from running automatically at startup
sudo systemctl disable cups-browsed.service || true

exit 0
