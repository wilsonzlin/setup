#!/usr/bin/env bash

set -e

pushd "$( mktemp -d )"

echo 'export DOTNET_CLI_TELEMETRY_OPTOUT=1' >> "$HOME/.profile"

wget -q "$sl_dotnetcore_sdk_url" -O dotnetcore.deb

sudo dpkg -i dotnetcore.deb

sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y dotnet-sdk-2.2

popd
