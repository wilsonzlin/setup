#!/usr/bin/env bash

set -e

sudo apt install -y docker.io

sudo usermod -a -G docker "$USER"

curl "$sl_docker_compose_url" -o "$HOME/Applications/docker-compose"
chmod +x "$HOME/Applications/docker-compose"
ln -s "$HOME/Applications/docker-compose" "$HOME/bin/"
