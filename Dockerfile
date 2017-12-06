FROM ubuntu
ENV INSTALL_DIR=/usr/local/share
RUN apt-get upgrade -y && apt-get update -y && apt-get install -y apt-transport-https software-properties-common python-software-properties curl python3 debconf-utils

RUN add-apt-repository -y ppa:webupd8team/java
# RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list 
# RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 
RUN apt-get update -y
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN apt-get install -y oracle-java8-installer  

ENV SCALA_HOME=$INSTALL_DIR/scala
RUN mkdir -p $SCALA_HOME 
RUN curl -L https://downloads.lightbend.com/scala/2.12.4/scala-2.12.4.tgz | tar zxf - -C $SCALA_HOME --strip-components=1 
RUN curl -L https://github.com/sbt/sbt/releases/download/v1.0.4/sbt-1.0.4.tgz | tar zxf - -C $SCALA_HOME --strip-components=1
ENV PATH=$PATH:$SCALA_HOME/bin


ENV SPARK_HOME=$INSTALL_DIR/spark
RUN mkdir -p $SPARK_HOME 
RUN curl -L http://apache.claz.org/spark/spark-2.2.0/spark-2.2.0.tgz | tar zxf - -C $SPARK_HOME --strip-components=1
RUN cd  $SPARK_HOME && sbt package

ENV PATH=$PATH:$SPARK_HOME/bin
