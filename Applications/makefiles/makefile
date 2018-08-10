.PHONY: all
all: clojure

.PHONY: rlwrap
rlwrap:
	make -f rlwrap.makefile

.PHONY: java
java:
	make -f java.makefile

.PHONY: clojure
clojure: rlwrap java
	make -f clojure.makefile
