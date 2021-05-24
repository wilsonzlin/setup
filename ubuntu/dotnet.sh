#!/usr/bin/env bash

set -e

pushd "$( mktemp -d )"

echo 'export DOTNET_CLI_TELEMETRY_OPTOUT=1' >> "$HOME/.zshenv"

wget "https://packages.microsoft.com/config/ubuntu/$sl_lsb_release_version/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

sudo apt update
sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y dotnet-sdk-5.0 aspnetcore-runtime-5.0

popd
