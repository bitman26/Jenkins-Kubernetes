FROM jenkins/jenkins
USER root
RUN apt-get update && apt-get install -y make git openjdk-17-jdk
RUN mkdir -p /srv/backup && chown jenkins:jenkins /srv/backup
USER jenkins
RUN echo 2.112 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
RUN echo 2.112 > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
ENV JAVA_HOME /user/lin/jvm/java-17-openjdk-amd64
COPY --chown=jenkins:jenkins ./backup/FULL-2024-01-28_19-33 /var/jenkins_home