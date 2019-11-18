#!/usr/bin/env bash

set -e

pushd "$(mktemp -d)" > /dev/null

wget "$sl_bat_url" -O bat.deb

sudo dpkg -i bat.deb

popd > /dev/null
