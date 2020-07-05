#!/usr/bin/env bash

set -e

sudo apt install -y sqlite3

sudo add-apt-repository -y ppa:linuxgndu/sqlitebrowser
sudo apt update
sudo apt intsall sqlitebrowser
