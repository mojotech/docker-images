FROM debian:wheezy
MAINTAINER mojotech <ops@mojotech.com>

ENV DEBIAN_FRONTEND noninteractive

ADD apt /etc/apt
RUN apt-key add /etc/apt/keys/*
RUN apt-get update
RUN apt-get install -y ca-certificates vim-tiny

CMD []
ENTRYPOINT []
