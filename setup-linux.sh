#!/usr/bin/env bash

# TESTED ON lubuntu 16.04 and Linux Mint 18.1
# Don't install nvidia-367, as that might cause conflicts and this script should be device-independent
# Don't need TrueCrypt - just use built-in tools to mount

set -e

if [[ $EUID -eq 0 ]]; then
    echo "This script should not be run using sudo or as the root user"
    echo "Sudo commands will be run as necessary, but some actions require them to be run as you"
    exit 1
fi

LSB_RELEASE="$(lsb_release -s -c)"
if [ "$LSB_RELEASE" == "serena" ]; then
    LSB_RELEASE="xenial"
fi

rm -rf ~/.setup-linux
mkdir ~/.setup-linux
cd ~/.setup-linux

echo 'set tabsize 4' > ~/.nanorc

sudo apt update
sudo apt install -y curl software-properties-common wget

curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
sudo add-apt-repository -y ppa:ondrej/php
sudo add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian $LSB_RELEASE contrib"
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -

sudo apt update
sudo apt dist-upgrade -y

sudo apt install -y \
    build-essential \
    dkms \
    exfat-fuse \
    exfat-utils \
    geany \
    gimp \
    git \
    gparted \
    libcurl4-openssl-dev \
    libffi-dev \
    libncurses5-dev \
    libpcre3-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libyaml-dev \
    lua5.1 \
    make \
    mpv \
    mupdf \
    mysql-server \
    nano \
    nodejs \
    perl \
    php7.1 \
    php7.1-mbstring \
    php7.1-mcrypt \
    php7.1-mysql \
    python-software-properties \
    silversearcher-ag \
    sqlite3 \
    viewnior \
    virtualbox-5.1 \
    vlc \
    zlib1g-dev \

VBOX_VERSION=$(vboxmanage -v)
VBOX_VERSION_POINT=$(echo $VBOX_VERSION | cut -d 'r' -f 1)
VBOX_VERSION_BUILD=$(echo $VBOX_VERSION | cut -d 'r' -f 2)
VBOX_EXTPACK_FILENAME="Oracle_VM_VirtualBox_Extension_Pack-$VBOX_VERSION_POINT-$VBOX_VERSION_BUILD.vbox-extpack"
wget http://download.virtualbox.org/virtualbox/$VBOX_VERSION_POINT/$VBOX_EXTPACK_FILENAME
sudo VBoxManage extpack install $VBOX_EXTPACK_FILENAME --replace

COMPOSER_INSTALLER_EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
COMPOSER_INSTALLER_ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

if [ "$COMPOSER_INSTALLER_ACTUAL_SIGNATURE" = "$COMPOSER_INSTALLER_EXPECTED_SIGNATURE" ]; then
    php composer-setup.php --quiet
    rm composer-setup.php
    sudo mv composer.phar /usr/local/bin/composer
fi

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_aliases
echo 'eval "$(rbenv init -)"' >> ~/.bash_aliases
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_aliases
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

rbenv install 2.3.3
rbenv global 2.3.3

wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"  -O chrome.deb
sudo dpkg -i chrome.deb || true # Avoid failing if dependencies are not installed -- this is fixed later with `apt install -f`

wget "https://go.microsoft.com/fwlink/?LinkID=760868" -O vscode.deb
sudo dpkg -i vscode.deb || true

wget "https://github.com/atom/atom/releases/download/v1.13.1/atom-amd64.deb" -O atom.deb
sudo dpkg -i atom.deb || true

wget "https://download3.tixati.com/download/tixati_2.51-1_amd64.deb" -O tixati.deb
sudo dpkg -i tixati.deb || true

sudo apt install -y -f

sudo apt purge -y \
    audacious* \
    brasero* \
    gpicview* \
    guvcview* \
    hexchat* \
    lubuntu-software-center \
    mplayer* \
    mtpaint* \
    pidgin* \
    pix* \
    plymouth-theme-ubuntu-text \
    rhythmbox* \
    simple-scan* \
    sylpheed* \
    thunderbird* \
    tomboy* \
    transmission* \
    update-notifier \
    xfburn* \
    xplayer* \
    xviewer* \

sudo apt autoremove -y
sudo apt clean

sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"$/GRUB_CMDLINE_LINUX_DEFAULT=""/' /etc/default/grub
sudo sed -i 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=3/' /etc/default/grub
sudo update-grub2

sudo mysql_secure_installation

sudo mkdir -p /etc/systemd/system/mysql.service.d/
echo '[Service]' | sudo tee /etc/systemd/system/mysql.service.d/override.conf
echo 'LimitNOFILE=infinity' | sudo tee -a /etc/systemd/system/mysql.service.d/override.conf

sudo sed -i '/^skip-external-locking$/a sql-mode = "STRICT_ALL_TABLES,ONLY_FULL_GROUP_BY,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i 's/^max_allowed_packet.*/max_allowed_packet = 4096M/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i 's/^thread_stack.*/thread_stack = 256K/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i 's/^#max_connections.*/max_connections = 1000000/' /etc/mysql/mysql.conf.d/mysqld.cnf

echo 'net.ipv4.ip_local_port_range = 1024 65535' | sudo tee -a /etc/sysctl.conf
if [ -d "/etc/lightdm" ]; then
    echo '[SeatDefaults]' | sudo tee /etc/lightdm/lightdm.conf.d/50-disable-guest-login.conf
    echo 'allow-guest=false' | sudo tee -a /etc/lightdm/lightdm.conf.d/50-disable-guest-login.conf
fi

read -e -p "Enter your Git name: " GIT_NAME
read -e -p "Enter your Git email: " GIT_EMAIL
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global core.editor nano
git config --global push.default simple

sudo ufw enable

cd ~
rm -rf ~/.setup-linux

echo
echo "================================================="
echo "All done! It's best to restart your computer now."
echo "================================================="
echo

exit 0
