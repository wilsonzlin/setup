#!/usr/bin/env bash

set -e

brew install duti

# Without `cask`, mpv is not installed to Applications and is more like a CLI.
brew cask install mpv

declare -a extensions=('avi' 'mkv' 'mp4')

for ext in "${extensions[@]}"; do
  duti -s io.mpv "$ext" all
done
