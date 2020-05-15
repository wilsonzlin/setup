#!/usr/bin/env bash

set -e

pushd "$( mktemp -d )"

sudo apt install -y clang-7 lld-7

sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-7 100
sudo update-alternatives --install /usr/bin/lld lld /usr/bin/lld-7 100

wget "$sl_clang_url" -O clang.tar.gz
tar --one-top-level=clang -xvf clang.tar.gz
mkdir -p ~/Applications/clang
mv clang/*/* ~/Applications/clang
ln -s ~/Applications/clang/bin ~/bin/clang
sudo apt install -y libtinfo5

popd
