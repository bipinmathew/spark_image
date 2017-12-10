#!/bin/bash
#Create a spark user and group from the passed in arguments.
#args uid gid [master|worker] host port [webport]
groupadd -g $2 spark
useradd -ms /bin/bash -u $1 -g $2 spark && chown spark:spark /home/spark && chown -R spark:spark $SPARK_HOME
echo "export SPARK_HOME=$SPARK_HOME" >> /home/spark/.profile
echo "export PYTHONPATH=\$SPARK_HOME/python:\$SPARK_HOME/python/lib/py4j-0.10.4-src.zip:$PYTHONPATH" >> /home/spark/.profile
echo "export PATH=\$SPARK_HOME/bin:\$PATH" >> /home/spark/.profile
if [ $3 = "master"]
then
  su - spark -c "start-master $4 $5 $6" 
elif[ $3 = "worker"]
  su - spark -c "start-worker $4 $5" 
then
  echo "No start mode for spark specified."
  exit 1
fi
#su - jupyter -c "jupyter notebook --ip=0.0.0.0 --port=8080 &> /dev/null"
