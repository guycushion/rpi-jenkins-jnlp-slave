FROM resin/raspberry-pi-openjdk:openjdk-8-jdk
LABEL maintainer "Jean-Sébastien Didierlaurent <js.didierlaurent@gmail.com>"

RUN apt-get update && \
    apt-get install \
    curl \
    wget \
    git \
    net-tools && \
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV JENKINS_SWARM_VERSION 3.3
ENV HOME /home/jenkins-slave

RUN useradd -c "Jenkins Slave user" -d $HOME -m jenkins-slave
RUN curl --create-dirs -sSLo /usr/share/jenkins/swarm-client-$JENKINS_SWARM_VERSION.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/$JENKINS_SWARM_VERSION/swarm-client-$JENKINS_SWARM_VERSION.jar \
  && chmod 755 /usr/share/jenkins

COPY files/jenkins-slave.sh /usr/local/bin/jenkins-slave.sh
RUN chmod +x /usr/local/bin/jenkins-slave.sh

USER jenkins-slave
VOLUME /home/jenkins-slave

ENTRYPOINT ["/usr/local/bin/jenkins-slave.sh"]