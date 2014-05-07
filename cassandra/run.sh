#!/bin/sh
IP=`hostname --ip-address`
CONFIG_TMPL="/etc/cassandra/cassandra.default.yaml"
CONFIG="/etc/cassandra/cassandra.yaml"
rm $CONFIG; cp $CONFIG_TMPL $CONFIG
sed -i -e "s/^listen_address.*/listen_address: $IP/" $CONFIG
sed -i -e "s/^rpc_address.*/rpc_address: 0.0.0.0/" $CONFIG

echo "*** Importing Schema"
/etc/init.d/cassandra start
cassandra-cli -host localhost -port 9160 -f /etc/cassandra/cassandra-schema.txt
/etc/init.d/cassandra stop

echo "*** Starting Cassandra"
/usr/sbin/cassandra -f





