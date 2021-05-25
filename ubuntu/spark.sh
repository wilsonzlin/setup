wget -O spark.tgz "$sl_apache_spark_url"

tar xf spark.tgz

rm spark.tgz

mv spark* "$HOME/Applications/spark"
