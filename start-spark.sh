#!/bin/bash
#Create a spark user and group from the passed in arguments.
#args uid gid [master|worker] host port webport
groupadd -g $2 spark
useradd -ms /bin/bash -u $1 -g $2 spark && chown spark:spark /home/spark && chown -R spark:spark $SPARK_HOME
echo "export SPARK_HOME=$SPARK_HOME" > /home/spark/.profile
echo "export PYTHONPATH=\$SPARK_HOME/python:\$SPARK_HOME/python/lib/py4j-0.10.4-src.zip:$PYTHONPATH" >> /home/spark/.profile
echo "export PATH=\$SPARK_HOME/bin:\$PATH" >> /home/spark/.profile
if [ $3 == 'master' ]
then
  pip3 install jupyter
  let "base_port = $6"
  let "spark_web_port = $base_port"
  let "jupyter_web_port = $spark_web_port+100"
  echo "/usr/local/bin/start-master.sh $4 $5 $spark_web_port" >> /home/spark/.profile
  echo "jupyter notebook --ip=0.0.0.0 --port=$jupyter_web_port --NotebookApp.token='' &> /dev/null &" >> /home/spark/.profile
  su - spark   
elif [ $3 == 'worker' ]
then
  echo "/usr/local/bin/start-worker.sh $4 $5 $6"  >> /home/spark/.profile
  su - spark 
else
  echo "No start mode for spark specified."
  exit 1
fi
