#!/usr/bin/env bash

set -e

pushd "$( mktemp -d )"

wget "$sl_ripgrep_url" -O rg.deb

sudo dpkg -i rg.deb

popd
