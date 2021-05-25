wget "$sl_delta_url" -O delta.deb

# Remove existing different package named `delta`.
sudo apt purge -y delta

sudo dpkg -i delta.deb

# Prevent restoring different repository version.
sudo apt-mark hold delta
