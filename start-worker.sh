#!/bin/bash
echo $SPARK_HOME/sbin/start-slave.sh spark://$1:$2 --webui-port $3
$SPARK_HOME/sbin/start-slave.sh spark://$1:$2 --webui-port $3
