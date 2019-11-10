#!/usr/bin/env bash

set -e

sudo apt install -y stubby

sudo systemctl --now disable stubby
