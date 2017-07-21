FROM jenkins:alpine

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

COPY bootstrap.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

