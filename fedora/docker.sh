#!/usr/bin/env bash

set -e

sudo dnf -y install dnf-plugins-core

sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf install -y docker-ce docker-ce-cli containerd.io

sudo usermod -a -G docker "$USER"
