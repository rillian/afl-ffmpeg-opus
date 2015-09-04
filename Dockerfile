FROM debian:latest

MAINTAINER Ralph Giles <giles@thaumas.net>

# update constainer
RUN apt-get update && apt-get upgrade -y

# install deps
RUN apt-get install -y git make gcc yasm wget

ADD Makefile /tmp/Makefile
RUN make -f /tmp/Makefile
