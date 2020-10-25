#!/usr/bin/env bash

# Only tested against Ubuntu 20.04, but should work with minor tweaks on:
# Ubuntu                 16.04.3, 17.10.1, 18.04 (Minimal), 19.10 (Minimal)
# Kubuntu                18.10 (Minimal)
# lubuntu                16.04
# Linux Mint (Cinnamon)  18.1, 18.2, 19.0, 19.1

set -e
shopt -s nullglob

pushd "$(dirname "$0")"

if [[ $EUID -eq 0 ]]; then
  echo "This script should not be run using sudo or as the root user"
  echo "Sudo commands will be run as necessary, but some actions require them to be run as you"
  exit 1
fi

echo ============== REQUIREMENTS ==============
echo "- A reliable Internet connection for the next hour or so"
echo "- Package sources set to local, fast mirrors"
echo "- Update manager disabled to prevent potential conflicts during process"
echo

# General prerequisites.
mkdir -p "$HOME/Applications"
mkdir -p "$HOME/bin"

# Make it so that $PATH also includes resolved paths of symlinked dirs in ~/bin.
# Put in file to avoid repeated additions.
if [ ! -f "$HOME/.profile.bindirs" ]; then
  cat << 'EOD' >> "$HOME/.profile.bindirs"
for d in $(find -L "$HOME/bin" -type d); do
  export PATH="$(realpath "$d"):$PATH"
done
EOD
  echo 'source "$HOME/.profile.bindirs"' >> "$HOME/.profile"
fi

if command -v python3; then
  python_cmd="python3"
else
  python_cmd="python"
fi

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

export sl_apache_spark_url='https://www-us.apache.org/dist/spark/spark-2.4.5/spark-2.4.5-bin-hadoop2.7.tgz'
export sl_bat_url='https://github.com/sharkdp/bat/releases/download/v0.15.4/bat_0.15.4_amd64.deb'
export sl_delta_url='https://github.com/dandavison/delta/releases/download/0.4.3/git-delta_0.4.3_amd64.deb'
export sl_docker_compose_url="https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)"
export sl_dotnetcore_sdk_url="https://packages.microsoft.com/config/ubuntu/$sl_lsb_release_version/packages-microsoft-prod.deb"
export sl_flutter_url='https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_1.17.1-stable.tar.xz'
export sl_foundationdb_clients_url='https://www.foundationdb.org/downloads/6.2.25/ubuntu/installers/foundationdb-clients_6.2.25-1_amd64.deb'
export sl_foundationdb_url='https://www.foundationdb.org/downloads/6.2.25/ubuntu/installers/foundationdb-server_6.2.25-1_amd64.deb'
export sl_gitui_url='https://github.com/extrawurst/gitui/releases/download/v0.10.1/gitui-linux-musl.tar.gz'
export sl_hub_url='https://github.com/github/hub/releases/download/v2.14.1/hub-linux-amd64-2.14.1.tgz'
export sl_jetbrains_toolbox_url='https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.18.7455.tar.gz'
export sl_maven_url='https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz'
export sl_mysql_apt_url='https://dev.mysql.com/get/mysql-apt-config_0.8.15-1_all.deb'
export sl_node_version='15'
export sl_protobuf_url='https://github.com/protocolbuffers/protobuf/releases/download/v3.12.1/protoc-3.12.1-linux-x86_64.zip'
export sl_ripgrep_url='https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb'
export sl_rstudio_url='https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.2.5033-amd64.deb'

export DEBIAN_FRONTEND=noninteractive
# Prerequisites.
sudo apt update
sudo apt install -y curl wget software-properties-common

echo 'Now reading from stdin for list of atoms...'
while read line; do
  for script in $line; do
    bash "ubuntu/$script.sh" || exit 1
    echo "Processed $script"
  done
done

# Post-install update and cleanup.
sudo apt dist-upgrade -y
sudo apt autoremove -y

echo
echo "================================================="
echo "Restart your device to complete the setup"
echo "================================================="
echo

popd
