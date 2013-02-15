.PHONY: all clean distclean

VPATH  +=

CC = gcc
LD = gcc
AR = ar
#-----------------------------------------------------------------------------
SUBPROJS = libs3 libpdp bench
.PHONY: $(SUBPROJS)

all: $(SUBPROJS)

libs3:
	if [! -d libs3 ]; then \
		git clone https://github.com/ceph/libs3.git \
	fi
	@
	@echo "Building libs3"
	$(MAKE) -C libs3

libpdp:
	@echo "Building libpdp"
	$(MAKE) -C libpdp all

bench:
	@echo "Building the pdp_bench benchmarking utility"
	$(MAKE) -C tools all

