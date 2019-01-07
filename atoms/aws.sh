#!/usr/bin/env bash

set -e

sudo apt install -y python3-pip

# Repo version of awscli is out of date
pip3 install --user awscli
