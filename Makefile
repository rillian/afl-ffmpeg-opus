# GNU makefile for setting up and running fuzzer.

all: findings opus_testvectors ffmpeg afl

AFL_VERSION = 1.92b

afl: afl-$(AFL_VERSION)

afl-$(AFL_VERSION):
	wget -q http://lcamtuf.coredump.cx/afl/releases/$@.tgz
	tar xf $@.tgz
	$(MAKE) -C $@

findings:
	mkdir $@

# Grab opus versions of the spec testsuite as a starting point.
opus_testvectors:
	mkdir $@
	cd $@ && for v in $$(seq 12); do \
	  wget -q https://people.xiph.org/~greg/opus_testvectors/testvector$${v}.bit.opus; \
	  done
  
CC=afl-$(AFL_VERSION)/afl-gcc
ffmpeg: afl
	git clone https://github.com/FFmpeg/ffmpeg $@
	cd $@ && ./configure --disable-everything --enable-encoder=pcm_s16le --enable-muxer=wav --enable-decoder=opus --enable-parser=opus --enable-demuxer=ogg --enable-filter=aresample --enable-protocol=file --enable-protocol=pipe
	cd ..
	make -C $@


clean:
	-$(MAKE) -C ffmpeg $@
	-$(MAKE) -C afl-$(AFL_VERSION) $@

distclean: clean
	$(RM) -r findings
	$(RM) -r opus_testvectors
	$(RM) -r ffmpeg
	$(RM) -r afl-$(AFL_VERSION)
	$(RM) afl-$(AFL_VERSION).tgz
