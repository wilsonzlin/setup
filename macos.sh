#!/usr/bin/env bash

set -e

pushd "$(dirname "$0")"

if [[ $EUID -eq 0 ]]; then
  echo "This script should not be run using sudo or as the root user"
  echo "Sudo commands will be run as necessary, but some actions require them to be run as you"
  exit 1
fi

xcode-select --install

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo 'Now reading from stdin for list of atoms...'
while read line; do
  for script in $line; do
    bash "macos/$script.sh" || exit 1
    echo "Processed $script"
  done
done

popd
