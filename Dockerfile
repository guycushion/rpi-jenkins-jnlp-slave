FROM resin/raspberry-pi-openjdk:openjdk-8-jdk
LABEL maintainer "Jean-Sébastien Didierlaurent <js.didierlaurent@gmail.com>"

RUN apt-get update && \
    apt-get install \
    curl \
    wget \
    git && \
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Slave.jar
ARG VERSION=3.7
RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

COPY files/jenkins-slave /usr/local/bin/jenkins-slave
RUN chmod +x /usr/local/bin/jenkins-slave

# Create Jenkins User
RUN useradd jenkins -m -s /bin/bash

USER jenkins
RUN mkdir /home/jenkins/.jenkins
VOLUME /home/jenkins/.jenkins
WORKDIR /home/jenkins

ENTRYPOINT ["jenkins-slave"]