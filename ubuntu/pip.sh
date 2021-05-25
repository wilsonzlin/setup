# Add pip user installs to PATH.
echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshenv"
# Add pip user installs to PYTHONPATH
echo 'export PYTHONPATH="$HOME/.local${PYTHONPATH:+:${PYTHONPATH}}"' >> "$HOME/.zshenv"

sudo apt install -y python3-pip

pip3 install pipenv
