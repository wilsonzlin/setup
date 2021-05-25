curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
# The repo is always 'xenial'
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal.list
sudo apt update
sudo apt install -y signal-desktop
