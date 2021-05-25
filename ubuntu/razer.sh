sudo apt install -y \
  libusb-1.0.0-dev \
  libc6-dev-i386 \
  cmake \
  python3 \
  python3-pyside \
  python3-distutils

filename="razercfg-0.39"

wget "https://bues.ch/razercfg/$filename.tar.bz2" -O razer.tar.bz2

tar -xvjf razer.tar.bz2

cd "$filename"

cmake .
make

sudo make install

sudo systemctl start razerd
