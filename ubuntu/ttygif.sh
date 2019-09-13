#!/usr/bin/env bash

set -e

pushd "$(mktemp -d)"

sudo apt-get install -y imagemagick ttyrec gcc x11-apps make git

git clone https://github.com/icholy/ttygif.git

cd ttygif
make
sudo make install

# Make sure `export WINDOWID=$(xdotool getwindowfocus)` is in the non-login shell file.
# This isn't set here as some users override the file later with their own synchronised version.

# ImageMagick may run out of resources when running ttygif, and it's possible to increase/remove
# resource limits; see https://github.com/ImageMagick/ImageMagick/issues/396 for more details.
# This is not done here as removing limits can cause the system to run out of resources and freeze.

popd