# GNU makefile for setting up and running fuzzer.

all: findings opus_testvectors ffmpeg afl

afl: afl-1.92b

afl-1.92b:
	wget -q http://lcamtuf.coredump.cx/afl/releases/$@.tgz
	tar xf $@.tgz

findings:
	mkdir $@

# Grab opus versions of the spec testsuite as a starting point.
opus_testvectors:
	mkdir $@
	cd $@
	for v in $$(seq 12); do \
	  wget -q https://people.xiph.org/~greg/opus_testvectors/testvector$${v}.bit.opus; \
	  done
	cd ..
  
ffmpeg:
	git clone https://github.com/FFmpeg/ffmpeg


