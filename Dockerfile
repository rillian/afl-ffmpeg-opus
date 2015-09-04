FROM ubuntu:14:04
MAINTAINER Ralph Giles <giles@thaumas.net>

# update constainer
RUN apt-get update
RUN apt-get upgrade

# install deps
RUN apt-get install git make gcc yasm wget

RUN wget http://lcamtuf.coredump.cx/afl/releases/afl-1.92b.tgz
RUN tar xf afl-1.92.tgz

RUN git clone https://github.com/FFmpeg/ffmpeg
