for p in autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm6 libgdbm-dev; do
  # Some packages may not be available.
  sudo apt install -y $p || true
done

# Script checks PATH at end and errors if rbenv isn't in it.
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash || true
