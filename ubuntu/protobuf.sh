#!/usr/bin/env bash

set -e

pushd "$( mktemp -d )"

wget "$sl_protobuf_url" -O proto.zip
sudo unzip -o proto.zip -d /usr/local bin/protoc
sudo unzip -o proto.zip -d /usr/local include/*
rm -f proto.zip

popd
