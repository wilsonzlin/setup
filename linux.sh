#!/usr/bin/env bash

# TESTED ON
# - Ubuntu 20.04.0 (Minimal)
#
# DOES NOT WORK ON
# - Ubuntu 20.04.2 (Minimal): preinstalled packages have unresolvable dependency conflict with libc6 versions.
#
# MIGHT WORK WITH MINOR TWEAKS ON:
# - Ubuntu                 16.04.3, 17.10.1, 18.04 (Minimal), 19.10 (Minimal)
# - Kubuntu                18.10 (Minimal)
# - lubuntu                16.04
# - Linux Mint (Cinnamon)  18.1, 18.2, 19.0, 19.1

set -euo pipefail
shopt -s nullglob

pushd "$(dirname "$0")"

if [[ $EUID -eq 0 ]]; then
  echo "This script should not be run using sudo or as the root user"
  echo "Sudo commands will be run as necessary, but some actions require them to be run as you"
  exit 1
fi

echo ============== REQUIREMENTS ==============
echo "- A reliable Internet connection for the next hour or so"
echo "- Package sources set to local, fast, reliable mirrors"
echo "- Update manager disabled to prevent potential conflicts during process"
echo

# General prerequisites.
mkdir -p "$HOME/Applications"
mkdir -p "$HOME/bin"

# Make it so that $PATH also includes resolved paths of symlinked dirs in ~/bin.
# Put in file to avoid repeated additions.
if [ ! -f "$HOME/.zshenv.bindirs" ]; then
  cat << 'EOD' >> "$HOME/.zshenv.bindirs"
for d in $(find -L "$HOME/bin" -type d); do
  export PATH="$(realpath "$d"):$PATH"
done
EOD
  echo 'source "$HOME/.zshenv.bindirs"' >> "$HOME/.zshenv"
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
lsb_release_version "hirsute" "21.04"
lsb_release_version "groovy"  "20.10"
lsb_release_version "focal"   "20.04"
lsb_release_version "eoan"    "19.10"
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
echo "Detected OS: $sl_lsb_release_version $sl_lsb_release"

export sl_apache_spark_url='https://apache.mirror.digitalpacific.com.au/spark/spark-3.1.1/spark-3.1.1-bin-hadoop3.2.tgz'
export sl_bat_url='https://github.com/sharkdp/bat/releases/download/v0.18.1/bat_0.18.1_amd64.deb'
export sl_delta_url='https://github.com/dandavison/delta/releases/download/0.7.1/git-delta_0.7.1_amd64.deb'
export sl_docker_compose_url='https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64'
export sl_flutter_url='https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_2.2.0-stable.tar.xz'
export sl_foundationdb_clients_url='https://www.foundationdb.org/downloads/6.3.12/ubuntu/installers/foundationdb-clients_6.3.12-1_amd64.deb'
export sl_foundationdb_url='https://www.foundationdb.org/downloads/6.3.12/ubuntu/installers/foundationdb-server_6.3.12-1_amd64.deb'
export sl_gitui_url='https://github.com/extrawurst/gitui/releases/download/v0.15.0/gitui-linux-musl.tar.gz'
export sl_hub_url='https://github.com/github/hub/releases/download/v2.14.2/hub-linux-amd64-2.14.2.tgz'
export sl_jetbrains_toolbox_url='https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.20.8352.tar.gz'
export sl_maven_url='https://www.strategylions.com.au/mirror/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.tar.gz'
export sl_mysql_apt_url='https://dev.mysql.com/get/mysql-apt-config_0.8.17-1_all.deb'
export sl_protobuf_url='https://github.com/protocolbuffers/protobuf/releases/download/v3.17.0/protoc-3.17.0-linux-x86_64.zip'
export sl_ripgrep_url='https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb'
export sl_rstudio_url='https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.4.1106-amd64.deb'

# Prerequisites.
apt_retry_line='APT::Acquire::Retries "5";'
apt_retry_conf=/etc/apt/apt.conf.d/80-retries
grep -qF -- "$apt_retry_line" "$apt_retry_conf" || echo "$apt_retry_line" | sudo tee -a "$apt_retry_conf"
sudo apt update
sudo apt install -y curl wget software-properties-common
# Don't do any automatic system upgrades as we may be installing a single atom and not necessarily running after a fresh OS install.

echo "Now reading from $1 for list of atoms..."
# -r to avoid mangling backslashes.
# -u 10 to avoid scripts that require reading from stdin (e.g. TTY input) read from the file.
while read -r -u 10 line; do
  for script in $line; do
    echo "===================="
    echo "Starting $script..."
    echo "===================="
    bash -c "set -Eeuxo pipefail; shopt -s nullglob; pushd \"\$(mktemp -d)\" > /dev/null; $(<ubuntu/"$script".sh); popd > /dev/null"
    echo "===================="
    echo "$script ended"
    echo "===================="
  done
done 10< "$1"

# Post-install update and cleanup.
echo "===================="
echo "Running post-install update and cleanup..."
echo "===================="
sudo UCF_FORCE_CONFOLD=1 DEBIAN_FRONTEND=noninteractive apt -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold dist-upgrade -y
sudo apt autoremove -y

echo "===================="
echo "All done"
echo "===================="

popd
