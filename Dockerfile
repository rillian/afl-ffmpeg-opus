FROM debian:latest

MAINTAINER Ralph Giles <giles@thaumas.net>

# update constainer
RUN apt-get update && apt-get upgrade -y

# install deps
RUN apt-get install -y git make gcc yasm wget

# set up non-root user
ENV USER worker
ENV HOME /home/$USER
RUN useradd -d $HOME -m $USER
WORKDIR $HOME
USER $USER

ADD Makefile ./
RUN make

CMD make test
