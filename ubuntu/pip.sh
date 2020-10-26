#!/usr/bin/env bash

# Add pip user installs to PATH.
echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.profile"
# Add pip user installs to PYTHONPATH
echo 'export PYTHONPATH="$HOME/.local${PYTHONPATH:+:${PYTHONPATH}}"' >> "$HOME/.profile"

pip3 install pipenv
