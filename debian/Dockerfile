FROM debian:wheezy
MAINTAINER mojotech <ops+docker@mojotech.com>

ENV DEBIAN_FRONTEND noninteractive

ADD apt /etc/apt
RUN apt-key add /etc/apt/keys/*
RUN apt-get update
RUN apt-get install -y \
  build-essential \
  ca-certificates \
  curl \
  git \
  locales \
  lsof \
  procps \
  vim-tiny

CMD []
ENTRYPOINT []
