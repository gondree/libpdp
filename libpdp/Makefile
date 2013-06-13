.PHONY: all clean distclean

VPATH  += src src/apdp src/cpor src/macpdp src/sepdp

CC = gcc
LD = gcc
AR = ar
#-----------------------------------------------------------------------------
INCLUDES  = -Iinc -Isrc
INCLUDES += -Isrc/apdp -Isrc/cpor -Isrc/macpdp -Isrc/sepdp
INCLUDES += -I../libs3/inc

CFLAGS  = -Wall -g $(INCLUDES)
CFLAGS += -D_S3_SUPPORT
CFLAGS += -D_THREAD_SUPPORT
CFLAGS += -D_TIMING_DATA
# CFLAGS += -D_PDP_DEBUG

OBJS  = pdp_generic.o pdp_misc.o pdp_key.o pdp_file.o pdp_s3.o
OBJS += macpdp.o macpdp_key.o macpdp_file.o macpdp_s3.o
OBJS += apdp.o apdp_key.o apdp_file.o apdp_s3.o apdp_serialize.o
OBJS += cpor.o cpor_key.o cpor_file.o cpor_s3.o cpor_serialize.o
OBJS += sepdp.o sepdp_key.o sepdp_file.o sepdp_s3.o sepdp_serialize.o

all: libpdp.a

clean:
	rm -rf *.o *.dSYM

distclean: clean
	rm -rf libpdp.a

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

libpdp.a: $(OBJS)
	$(AR) rvs $@ $^

