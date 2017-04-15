Look the original project : https://github.com/jenkinsci/docker-jnlp-slave

# Raspberri Pi Jenkins JNLP Agent Docker image

This is an image for running JNPL Slave for Jenkins on raspberry pi.

## Running

To run a Docker container

    docker run jsdidierlaurent/rpi-jenkins-jnlp-slave -url http://jenkins-server:port <secret> <agent name>

Optional environment variables:

* `JENKINS_URL`: url for the Jenkins server, can be used as a replacement to `-url` option, or to set alternate jenkins URL
* `JENKINS_TUNNEL`: (`HOST:PORT`) connect to this agent host and port instead of Jenkins server, assuming this one do route TCP traffic to Jenkins master. Useful when when Jenkins runs behind a load balancer, reverse proxy, etc.
* `JENKINS_SECRET`: agent secret, if not set as an argument
* `JENKINS_AGENT_NAME`: agent name, if not set as an argument