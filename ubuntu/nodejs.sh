curl -sL "https://deb.nodesource.com/setup_16.x" | sudo -E bash -

# Don't install other tools (e.g. build-essential, gcc) as they may conflict with other chosen tools like LLVM.
sudo apt install -y nodejs

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
