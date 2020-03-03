FROM openjdk:8u242-jdk

ARG SBT_VERSION=1.3.8
ARG SCALA_VERSION=2.12.8
ARG NPM_VERSION=6.8

RUN apt update && apt install -y \
  unzip \
  vim \
  git \
  curl

# Install sbt
RUN \
  curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get install sbt && \
  sbt sbtVersion


# Install scala
# RUN \
#   curl -L -o scala-$SCALA_VERSION.deb https://downloads.lightbend.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.deb && \
#   dpkg -i scala-$SCALA_VERSION.deb && \
#   rm scala-$SCALA_VERSION.deb && \
#   apt-get install scala

# Install scala
RUN \
  curl -L -o scala-$SCALA_VERSION.tgz https://downloads.lightbend.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz && \
  tar xvf scala-$SCALA_VERSION.tgz && \
  mv scala-$SCALA_VERSION /usr/lib && \
  ln -s /usr/lib/scala-$SCALA_VERSION /usr/lib/scala && \
  echo "export PATH=$PATH:/usr/lib/scala/bin" >> ~/.bashrc && \
  rm scala-$SCALA_VERSION.tgz

# Install npm
RUN \
  curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  apt-get install nodejs && \
  npm install -g npm@$NPM_VERSION && \
  node -v && \
  npm -v


EXPOSE 8000
EXPOSE 9000
EXPOSE 5000
EXPOSE 8888