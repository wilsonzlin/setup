#!/usr/bin/env bash

set -e

sudo add-apt-repository -y ppa:nginx/stable

sudo apt-get update

sudo apt install -y nginx
