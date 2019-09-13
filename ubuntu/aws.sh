#!/usr/bin/env bash

set -e

sudo apt install -y python3-dev python3-pip python3-setuptools python3-wheel

# Repo version of awscli is out of date
pip3 install --user awscli aws-shell
