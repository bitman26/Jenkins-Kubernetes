FROM jenkins/jenkins
USER root
RUN apt-get update && apt-get install -y make git openjdk-17-jdk
RUN mkdir -p /srv/backup && chown jenkins:jenkins /srv/backup
USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
ENV JAVA_HOME /user/lin/jvm/java-17-openjdk-amd64
