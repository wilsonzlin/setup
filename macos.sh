#!/usr/bin/env bash

set -e

pushd "$(dirname "$0")"

if [[ $EUID -eq 0 ]]; then
  echo "This script should not be run using sudo or as the root user"
  echo "Sudo commands will be run as necessary, but some actions require them to be run as you"
  exit 1
fi

atoms_to_run="$1"
if [ ! -f "$atoms_to_run" ]; then
  echo "File containing atoms to run not provided"
  exit 2
fi

xcode-select --install

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

while IFS="" read -r script || [ -n "$script" ]; do
  bash "macos/$script.sh" || exit 1
done < "$atoms_to_run"

popd
