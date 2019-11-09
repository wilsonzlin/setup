#!/usr/bin/env bash

# TESTED ON:
# Ubuntu                 16.04.3, 17.10.1, 18.04 (Minimal)
# Kubuntu                18.10 (Minimal)
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

atoms_to_run="$1"
if [ ! -f "$atoms_to_run" ]; then
  echo "File containing atoms to run not provided"
  exit 2
fi

echo ============== REQUIREMENTS ==============
echo "- A reliable Internet connection for the next hour or so"
echo "- Package sources set to local, fast mirrors"
echo "- Update manager disabled to prevent potential conflicts during process"
echo

read -p "Do you wish to continue? (y) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Setup cancelled"
  exit 1
fi

# General prerequisites.
mkdir -p "$HOME/Applications"
mkdir -p "$HOME/bin"

# Make it so that $PATH also includes resolved paths of symlinked dirs in ~/bin.
cat << 'EOD' >> "$HOME/.profile"
for d in $(find -L "$HOME/bin" -type d); do
  PATH="$(realpath "$d"):$PATH"
done
EOD

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
  atoms_dir="ubuntu"

  # Get lsb_release at least once in case it's not an alias.
  sl_lsb_release="$(lsb_release -s -c)"
  actual_lsb_release() {
    if [ "X$(lsb_release -s -c)" == "X$1" ]; then
      sl_lsb_release="$2"
    fi
  }
  # Use Ubuntu versions to represent Linux Mint versions.
  actual_lsb_release "tessa"  "bionic"
  actual_lsb_release "tara"   "bionic"
  actual_lsb_release "sylvia" "xenial"
  actual_lsb_release "sonya"  "xenial"
  actual_lsb_release "serena" "xenial"
  actual_lsb_release "sarah"  "xenial"
  export sl_lsb_release

  lsb_release_version() {
    if [ "$sl_lsb_release" == "$1" ]; then
      sl_lsb_release_version="$2"
    fi
  }

  lsb_release_version "disco"   "19.04"
  lsb_release_version "cosmic"  "18.10"
  lsb_release_version "bionic"  "18.04"
  lsb_release_version "artful"  "17.10"
  lsb_release_version "zesty"   "17.04"
  lsb_release_version "yakkety" "16.10"
  lsb_release_version "xenial"  "16.04"
  lsb_release_version "wily"    "15.10"
  lsb_release_version "vivid"   "15.04"
  lsb_release_version "utopic"  "14.10"
  lsb_release_version "trusty"  "14.04"
  lsb_release_version "saucy"   "13.10"
  lsb_release_version "raring"  "13.04"
  lsb_release_version "quantal" "12.10"
  export sl_lsb_release_version

  export sl_dotnetcore_sdk_url="https://packages.microsoft.com/config/ubuntu/$sl_lsb_release_version/packages-microsoft-prod.deb"
  export sl_mysql_apt_url="https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb"
  # This is the RStudio Desktop package for Ubuntu 18 64-bit.
  export sl_rstudio_url="https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.2.1335-amd64.deb"

  # Prerequisites.
  sudo apt install -y curl wget software-properties-common

elif [ $sl_is_fedora -eq 1 ]; then
  atoms_dir="fedora"

  # Prerequisites.
  sudo dnf install -y "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
fi

export sl_protobuf_url='https://github.com/protocolbuffers/protobuf/releases/download/v3.9.1/protoc-3.9.1-linux-x86_64.zip'
export sl_flutter_url='https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.9.1+hotfix.2-stable.tar.xz'
export sl_ripgrep_url='https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb'
export sl_jetbrains_toolbox_url='https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.13.4801.tar.gz'
export sl_apache_spark_url='https://www-us.apache.org/dist/spark/spark-2.4.4/spark-2.4.4-bin-hadoop2.7.tgz'
export sl_maven_url='http://apache.mirror.amaze.com.au/maven/maven-3/3.6.1/binaries/apache-maven-3.6.1-bin.tar.gz'
export sl_hub_url='https://github.com/github/hub/releases/download/v2.12.1/hub-linux-amd64-2.12.1.tgz'
export sl_node_version='11'

while IFS="" read -r script || [ -n "$script" ] ; do
  bash "$atoms_dir/$script.sh" || exit 1
done < "$atoms_to_run"

if [ $sl_is_ubuntu -eq 1 ] || [ $sl_is_mint -eq 1 ]; then
  # Postinstall update and cleanup.
  sudo apt dist-upgrade -y
  sudo apt autoremove -y
fi

echo
echo "================================================="
echo "Restart your device to complete the setup"
echo "================================================="
echo

exit 0
