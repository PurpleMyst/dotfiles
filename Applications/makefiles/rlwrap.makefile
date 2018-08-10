/usr/local/bin/rlwrap:
	git clone https://github.com/hanslub42/rlwrap
	cd rlwrap && \
	autoreconf --install && \
	./configure && \
	sudo make install
