wget "$sl_gitui_url" -O gitui.tar.gz
tar xzf gitui.tar.gz
mv ./gitui "$HOME/Applications/."
ln -s "$HOME/Applications/gitui" "$HOME/bin/"
