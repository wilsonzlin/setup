#!/usr/bin/env bash

set -e

pushd "$(mktemp -d)"

wget "$sl_hub_url" -O hub.tgz

tar -xf hub.tgz
rm hub.tgz

mv hub* "$HOME/Applications/hub"

ln -s "$(realpath "$HOME/Applications/hub/bin/hub")" "$HOME/bin"

popd
