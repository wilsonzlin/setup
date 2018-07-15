#!/usr/bin/env bash

set -e

export CLOUD_SDK_REPO="cloud-sdk-$sl_lsb_release"

echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo apt-get update
sudo apt-get install -y google-cloud-sdk
