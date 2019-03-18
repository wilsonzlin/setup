#!/usr/bin/env bash

set -e

pushd "$( mktemp -d )"

wget "$sl_jetbrains_toolbox_url" -O toolbox.tar.gz
tar -zxvf toolbox.tar.gz --one-top-level
mv toolbox/*/jetbrains-toolbox ~/Applications/.

popd
