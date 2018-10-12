#!/usr/bin/env bash

set -e

pushd "$( mktemp -d )"

wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.11.4269.tar.gz -O toolbox.tar.gz
tar -zxvf toolbox.tar.gz --one-top-level
mv toolbox/*/jetbrains-toolbox ~/Applications/.

popd
