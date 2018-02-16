#!/usr/bin/env bash

set -e

pushd "$( mktemp -d )"

wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -O chrome.deb
sudo dpkg -i chrome.deb || true # Avoid failing if dependencies are not installed -- this is fixed later with `apt install -f`

sudo apt install -y -f

popd

exit 0
