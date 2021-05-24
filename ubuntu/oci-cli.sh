#!/usr/bin/env bash

set -e

sudo apt install -y python3

bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)" --accept-all-defaults
