#!/usr/bin/env bash

# TESTED ON:
# Ubuntu                 16.04.3, 17.10.1, 18.04 (Minimal)
# lubuntu                16.04
# Linux Mint (Cinnamon)  18.1, 18.2, 19.0, 19.1
# Fedora Workstation     29

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

if command -v python3; then
  python_cmd="python3"
else
  python_cmd="python"
fi

check_platform() {
  "$python_cmd" -m platform | grep -qi "$1" && echo "1" || echo "0"
}
sl_is_ubuntu="$(check_platform "Ubuntu")"
sl_is_mint="$(check_platform "LinuxMint")"
sl_is_fedora="$(check_platform "Fedora")"

if [ $sl_is_ubuntu -eq 1 ] || [ $sl_is_mint -eq 1 ]; then
  atoms_dir_prefix="ubuntu"

  get_lsb_release() {
    if [ "X$(lsb_release -s -c)" == "X${2}" ]; then
      sl_lsb_release="${4}"
    fi
  }
  get_lsb_release "Linux Mint"    "serena"   "Ubuntu" "xenial"
  get_lsb_release "Linux Mint"    "sonya"    "Ubuntu" "xenial"
  get_lsb_release "Linux Mint"    "tara"     "Ubuntu" "bionic"
  get_lsb_release "Linux Mint"    "tessa"    "Ubuntu" "bionic"
  export sl_lsb_release

  # Prerequisite(s)
  sudo apt install -y curl wget software-properties-common snapd

elif [ $sl_is_fedora -eq 1 ]; then
  atoms_dir_prefix="fedora"

  # Prerequisite(s)
  sudo dnf install -y "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
  sudo dnf install -y snapd

fi

export sl_jetbrains_toolbox_url='https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.13.4801.tar.gz'
export sl_node_version='11'

for script in "$atoms_dir_prefix"-atoms/*.sh; do
  bash "$script" || break
done

echo
echo "================================================="
echo "Restart your device to complete the setup"
echo "================================================="
echo

exit 0
