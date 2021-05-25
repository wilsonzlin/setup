pushd "$HOME/Applications"

wget "$sl_maven_url" -O mvn.tar.gz

tar -zxvf mvn.tar.gz
rm mvn.tar.gz

mv apache-maven-* maven

ln -s "$(realpath maven/)" "$HOME/bin/"

popd
