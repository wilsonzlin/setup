#!/usr/bin/env bash

set -e

pushd "$(mktemp -d)" > /dev/null

# Avoid using repo managed by system, as they're not officially supported by Go and have caused dependency resolution issues in the past.

wget 'https://golang.org/dl/go1.16.4.linux-amd64.tar.gz'
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.16.4.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> "$HOME/.zshenv"

popd > /dev/null
