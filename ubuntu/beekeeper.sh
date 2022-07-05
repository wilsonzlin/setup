wget --quiet -O - https://deb.beekeeperstudio.io/beekeeper.key | sudo apt-key add -

echo "deb https://deb.beekeeperstudio.io stable main" | sudo tee /etc/apt/sources.list.d/beekeeper-studio-app.list

sudo apt update
sudo apt install -y beekeeper-studio
