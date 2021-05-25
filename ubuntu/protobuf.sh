wget "$sl_protobuf_url" -O proto.zip
sudo unzip -o proto.zip -d /usr/local bin/protoc
sudo unzip -o proto.zip -d /usr/local include/*
rm -f proto.zip
