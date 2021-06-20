# Avoid using repo managed by system, as they're not officially supported by Go and have caused dependency resolution issues in the past.

sudo rm -rf /usr/local/go
curl -L 'https://golang.org/dl/go1.16.4.linux-amd64.tar.gz' | sudo tar -C /usr/local -zxf -
echo 'export PATH="$PATH:/usr/local/go/bin"' >> "$HOME/.zshenv"
