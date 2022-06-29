curl -sL "https://deb.nodesource.com/setup_18.x" | sudo -E bash -

# Don't install other tools (e.g. build-essential, gcc) as they may conflict with other chosen tools like LLVM.
sudo apt install -y nodejs

# Install nvm
curl -o- "$sl_nvm_url" | bash
