FROM ubuntu:17.10

MAINTAINER Anthony Ikeda <anthony.ikeda@gmail.com>

RUN apt-get update
RUN apt-get install -y curl virtualbox

RUN curl -sSL https://dl.bintray.com/emccode/rexray/install | sh -

RUN mkdir -p $HOME/VirtualBox/Volumes

ADD config.yml /etc/rexray/config.yml

# ENTRYPOINT ["rexray", "service", "start"]
