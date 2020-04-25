#!/usr/bin/env bash

set -e

sudo apt install -y docker.io

sudo usermod -a -G docker "$USER"
