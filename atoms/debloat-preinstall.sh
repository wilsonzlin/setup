#!/usr/bin/env bash

set -e

# Purge unneeded packages
# Purging libreoffice* will break Linux Mint's UI
# gnome-control-center requires gnome-user-share and
#   a few libtotem* packages so don't purge *totem*
# cheese is heavily integrated into older versions of
#   Ubuntu so can't purge globally (it's also useful)
packages_to_remove="\
    abiword* \
    aisleriot* \
    audacious* \
    brasero* \
    btrfs-tools \
    eog* \
    evince* \
    gnome-calendar* \
    gnome-mahjongg* \
    gnome-mines* \
    gnome-mplayer* \
    gnome-orca* \
    gnome-software* \
    gnome-sudoku* \
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
    totem* \
    transmission* \
    ubuntu-software* \
    ubuntu-web-launchers \
    unity-webapps* \
    update-notifier \
    vim* \
    vino* \
    virtualbox-guest* \
    webapp-container* \
    webbrowser-app* \
    xfburn* \
    xpad \
    xplayer* \
    *xscreensaver* \
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
