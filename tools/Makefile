.PHONY: all clean distclean

VPATH  += src

CC = gcc
LD = gcc
AR = ar
#-----------------------------------------------------------------------------

#
# libpdp
#
LIBPDP = ../libpdp/libpdp.a
LIBPDP_INC = -I../libpdp/inc

#
# libtimeit
#
TIMEIT_LIB = ./lib/time_it/libtimeit.a
TIMEIT_INC = -I./lib/time_it

#
# libs3
#
LIBS3 = ../libs3/lib/libs3.a
LIBS3_TIMING = ./lib/libs3-2.0/build/lib/libs3.a
S3_INC = -I../libs3/inc
S3_LIB = $(LIBS3_TIMING)              # timing instrumentation in libs3
#S3_LIB = $(LIBS3)                    # no timing data

#-----------------------------------------------------------------------------
INCLUDES  = $(LIBPDP_INC) $(TIMEIT_INC) $(S3_INC)

CFLAGS    = -Wall -g $(INCLUDES)
CFLAGS   += -D_S3_SUPPORT
CFLAGS   += -D_THREAD_SUPPORT
CFLAGS   += -D_TIMING_DATA

LDFLAGS   = -lcrypto -pthread -lcurl -lcrypto -lxml2 -lz
LDFLAGS  += $(LIBPDP) $(S3_LIB)

all: pdp_bench

clean:
	rm -rf *.o *.dSYM *.a

distclean: clean
	rm -rf pdp_bench
	make -C ../libpdp distclean
	make -C ./lib/libs3-2.0 clean
	make -C ./lib/time_it clean

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

pdp_bench: pdp_bench.o $(LIBPDP) $(TIMEIT_LIB) $(S3_LIB)
	$(LD) $^ $(LDFLAGS) -o $@

$(LIBPDP) $(TIMEIT_LIB):
	make -C $(dir $@) $(notdir $@)

$(LIBS3_TIMING):
	make -C ./lib/libs3-2.0 all

