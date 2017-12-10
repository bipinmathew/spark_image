#!/bin/bash
#Create a spark user and group from the passed in arguments.
#Arguments [master|worker] uid gid
groupadd -g $3 spark
useradd -ms /bin/bash -u $2 -g $3 spark && chown spark:spark /home/spark && chown -R spark:spark $SPARK_HOME
echo "export SPARK_HOME=$SPARK_HOME" >> /home/spark/.profile
echo "export PYTHONPATH=\$SPARK_HOME/python:\$SPARK_HOME/python/lib/py4j-0.10.4-src.zip:$PYTHONPATH" >> /home/spark/.profile
echo "export PATH=\$SPARK_HOME/bin:\$PATH" >> /home/spark/.profile
su - spark

#su - jupyter -c "jupyter notebook --ip=0.0.0.0 --port=8080 &> /dev/null"

