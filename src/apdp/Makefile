
#-finstrument-functions -lSaturn -pg 

CFLAGS=-g -Wall -O0 -pg -DTIME_IT -I../../lib/libs3-2.0/build/include -I../../lib/time_it
S3LIB = ../../lib/libs3-2.0/build/lib/libs3.a
TIMEITLIB = ../../lib/time_it/libtimeit.a

.PHONY: pdp-file-cpu

all: pdp-misc.o pdp.h pdp-core.o pdp-keys.o pdp-file.o pdp-app.c
	gcc $(CFLAGS) -lpthread -lcrypto -o pdp pdp-app.c pdp-core.o pdp-misc.o pdp-keys.o pdp-file.o $(TIMEITLIB)

pdp-s3: pdp-misc.o pdp.h pdp-core.o pdp-keys.o pdp-file.o pdp-s3.o pdp-app.c $(S3LIB)
	gcc -DUSE_S3 $(CFLAGS) -lpthread -lcurl -lxml2 -lz -lcrypto -o pdp-s3 pdp-app.c pdp-core.o pdp-misc.o pdp-keys.o pdp-file.o pdp-s3.o $(S3LIB) $(TIMEITLIB)

pdp-cpu: pdp-misc.o pdp.h pdp-core.o pdp-keys.o pdp-file-cpu pdp-s3.o pdp-cpu.c
	gcc $(CFLAGS) -lpthread -lcurl -lxml2 -lz -lcrypto -o pdp-cpu pdp-cpu.c pdp-core.o pdp-misc.o pdp-keys.o pdp-file.o $(S3LIB) $(TIMEITLIB)

pdp-core.o: pdp-core.c pdp.h
	gcc $(CFLAGS) -c pdp-core.c

pdp-keys.o: pdp-keys.c pdp.h
	gcc $(CFLAGS) -c pdp-keys.c

pdp-misc.o: pdp-misc.c pdp.h
	gcc $(CFLAGS) -c pdp-misc.c

pdp-file-cpu: pdp-file.c pdp.h
	$(RM) pdp-file.o; gcc $(CFLAGS) -DCPU_TEST -c pdp-file.c -o pdp-file.o

pdp-file.o: pdp-file.c pdp.h
	gcc $(CFLAGS) -c pdp-file.c
	
pdp-s3.o: pdp-s3.c pdp.h
	gcc $(CFLAGS) -DUSE_S3 -c pdp-s3.c

pdplib: pdp-core.o pdp-misc.o pdp-keys.o pdp-file.o
	ar -rv pdplib.a pdp-core.o pdp-misc.o pdp-keys.o pdp-file.o

clean:
	rm -rf *.o *.tag pdp.dSYM pdp pdp-cpu pdp-s3
