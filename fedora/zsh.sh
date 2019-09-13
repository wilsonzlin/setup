#!/usr/bin/env bash

set -e

sudo dnf install -y zsh

printf '\033[0;31m\033[1m!!! oh-my-zsh installer will automatically launch zsh, exit it to continue setup !!!\n\033[0m'

# oh-my-zsh will chsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
