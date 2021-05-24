#!/usr/bin/env bash

set -e

pushd "$(mktemp -d)" > /dev/null

sudo apt install -y python3

wget 'https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh'

bash ./install.sh --accept-all-defaults

popd > /dev/null
