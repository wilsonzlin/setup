#!/usr/bin/env bash

set -e

curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo

sudo dnf install -y yarn
