#!/usr/bin/env bash

# TESTED ON:
# Ubuntu                 16.04.3, 17.10.1, 18.04 (Minimal)
# lubuntu                16.04
# Linux Mint (Cinnamon)  18.1, 18.2, 19.0, 19.1

set -e

cd "$(dirname "$0")"

if [[ $EUID -eq 0 ]]; then
  echo "This script should not be run using sudo or as the root user"
  echo "Sudo commands will be run as necessary, but some actions require them to be run as you"
  exit 1
fi

echo ============== REQUIREMENTS ==============
echo "- A reliable, working Internet connection for the next hour"
echo "- Package sources set to local, fast mirrors"
echo "- An hour of your free time as user interaction will be required"
echo

read -p "Do you wish to continue? (y) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Setup cancelled"
  [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

# Get Ubuntu/Debian release name
# Copied from https://deb.nodesource.com/setup_10.x

sl_lsb_release="$(lsb_release -s -c)"
get_lsb_release() {
  if [ "X${sl_lsb_release}" == "X${2}" ]; then
    sl_lsb_release="${4}"
  fi
}

get_lsb_release "Linux Mint"    "serena"   "Ubuntu" "xenial"
get_lsb_release "Linux Mint"    "sonya"    "Ubuntu" "xenial"
get_lsb_release "Linux Mint"    "tara"     "Ubuntu" "bionic"
get_lsb_release "Linux Mint"    "tessa"    "Ubuntu" "bionic"

export sl_lsb_release

bash prereq.sh

for script in atoms/*.sh; do
  bash "$script" || break
done

echo
echo "================================================="
echo "Restart your device to complete the setup"
echo "================================================="
echo

exit 0
