#!/usr/bin/env bash

set -e

echo "deb [arch=amd64] http://apt.postgresql.org/pub/repos/apt/ ${sl_lsb_release}-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt update
sudo apt install -y postgresql libpq-dev

pip3 install pgcli
sudo apt install -y pspg
mkdir -p "$HOME/.config/pgcli"
cat << 'EOD' >> "$HOME/.config/pgcli/config"
pager = /usr/bin/pspg --csv --rr=2 --quit-if-one-screen --ignore-case --csv-header on
table_format = csv
EOD
