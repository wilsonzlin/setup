#!/usr/bin/env bash

set -e

pushd "$( mktemp -d )"

wget "$sl_foundationdb_clients_url" -O fdbc.deb
sudo dpkg -i fdbc.deb

# Depends on the clients package.
wget "$sl_foundationdb_url" -O fdb.deb
sudo dpkg -i fdb.deb

popd
