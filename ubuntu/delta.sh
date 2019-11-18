#!/usr/bin/env bash

set -e

pushd "$(mktemp -d)" > /dev/null

wget "$sl_delta_url" -O delta.deb

sudo dpkg -i delta.deb

popd > /dev/null
