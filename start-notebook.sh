#!/bin/bash
#Create a jupyter user and group from the passed in arguments.
groupadd -g $2 jupyter
useradd -ms /bin/bash -u $1 -g $2 jupyter && chown jupyter:jupyter /home/jupyter
su - jupyter -c "jupyter notebook --ip=0.0.0.0 --port=8080 &> /dev/null"

