.PHONY: all clean distclean doc

VPATH  +=

CC = gcc
LD = gcc
AR = ar
#-----------------------------------------------------------------------------
SUBPROJS = libs3 libpdp bench
.PHONY: $(SUBPROJS)

all: bench

libs3:
	@echo "Getting libs3 source, if needed"
	[ -d libs3 ] || git clone https://github.com/ceph/libs3.git
	@echo "Building libs3"
	$(MAKE) -C libs3

libpdp: libs3
	@echo "Building libpdp"
	$(MAKE) -C libpdp all

bench: libpdp
	@echo "Building the pdp_bench benchmarking utility"
	$(MAKE) -C tools pdp_bench

doc: doxyfile
	doxygen doxyfile

clean:
	[ -d tools ] && $(MAKE) -C tools clean
	[ -d libpdp ] && $(MAKE) -C libpdp clean
	[ -d libs3 ] && $(MAKE) -C libs3 clean

