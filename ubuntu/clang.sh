#!/usr/bin/env bash

set -e

pushd "$(mktemp -d)" > /dev/null

# Avoid using apt.llvm.org as there can be conflicts with package resolution from previous experiences.

curl -L "https://github.com/llvm/llvm-project/releases/download/llvmorg-12.0.0/clang+llvm-12.0.0-x86_64-linux-gnu-ubuntu-$sl_lsb_release_version.tar.xz" | tar -Jxvf -
mv clang+llvm* "$HOME/Applications/llvm"

pushd "$HOME/Applications"
ln -s "$HOME/Applications/llvm/bin" llvm
popd

popd > /dev/null
