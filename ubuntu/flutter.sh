#!/usr/bin/env bash

set -e

file_name='flutter.tar.xz'
dest_dir="$HOME/Applications"

pushd "$dest_dir"

wget "$sl_flutter_url" -O "$file_name"

tar xf "$file_name"

rm "$file_name"

echo "export PATH=\"\$PATH:$dest_dir/flutter/bin\"" >> "$HOME/.zshenv"

flutter/bin/flutter config --no-analytics
flutter/bin/flutter precache

popd
