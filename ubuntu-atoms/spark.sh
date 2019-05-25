#!/usr/bin/env bash

set -e

pushd "$(mktemp -d)" > /dev/null

wget -O spark.tgz "$sl_apache_spark_url"

tar xf spark.tgz

rm spark.tgz

mv spark* "$HOME/Applications/spark"

popd > /dev/null
