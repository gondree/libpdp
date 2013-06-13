.PHONY: all clean distclean

VPATH  += 

CC = gcc
LD = gcc
AR = ar
#-----------------------------------------------------------------------------
INCLUDES  = 
CFLAGS    = -Wall -g -fPIC -O0 $(INCLUDES) -D_TIMING_DATA

all: libtimeit.a

clean:
	rm -rf *.o *.a *.dSYM

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

libtimeit.a: time_it.o
	$(AR) -cvq $@ $^

