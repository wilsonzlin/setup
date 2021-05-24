#!/usr/bin/env bash

set -e

sudo apt install -y parallel

echo 'alias parallel="parallel --will-cite"' >> "$HOME/.zshenv"
