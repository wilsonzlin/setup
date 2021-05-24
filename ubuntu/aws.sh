#!/usr/bin/env bash

set -e

pushd "$(mktemp -d)" > /dev/null

curl -o awscliv2.zip 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'
unzip awscliv2.zip
sudo ./aws/install

popd > /dev/null
