#!/usr/bin/env bash

pushd "$(mktemp -d)"

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $sl_lsb_release-cran35/"

sudo apt update

sudo apt install -y r-base

wget $sl_rstudio_url -O rstudio.deb

# Ignore missing dependencies.
sudo dpkg -i rstudio.deb || true

sudo apt install -yf

popd
