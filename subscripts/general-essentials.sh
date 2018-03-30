#!/usr/bin/env bash

set -e

sudo add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable

sudo apt update

sudo apt install -y \
    gimp \
    mpv \
    mupdf \
    viewnior \
    vlc \
    qbittorrent

exit 0
