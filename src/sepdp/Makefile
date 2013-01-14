
#-finstrument-functions -lSaturn -pg 

CFLAGS=-g -Wall -O0 -DTIME_IT -I../../lib/libs3-2.0/build/include -I../../lib/time_it
S3LIB = ../../lib/libs3-2.0/build/lib/libs3.a
TIMEITLIB = ../../lib/time_it/libtimeit.a

.PHONY: sepdp-file-cpu

all: sepdp-misc.o sepdp.h sepdp-keys.o sepdp-file.o sepdp-app.c
	gcc $(CFLAGS) -lcrypto -o sepdp sepdp-app.c sepdp-misc.o sepdp-keys.o sepdp-file.o $(TIMEITLIB)

sepdp-s3: sepdp-misc.o sepdp.h sepdp-keys.o sepdp-file.o sepdp-s3.o sepdp-app.c $(S3LIB)
	gcc -DUSE_S3 $(CFLAGS) -lpthread -lcurl -lxml2 -lz -lcrypto -o sepdp-s3 sepdp-app.c sepdp-misc.o sepdp-keys.o sepdp-file.o sepdp-s3.o $(S3LIB) $(TIMEITLIB)

sepdp-cpu: sepdp-misc.o sepdp.h sepdp-keys.o sepdp-file-cpu sepdp-cpu.c 
	gcc $(CFLAGS) -lpthread -lcurl -lxml2 -lz -lcrypto -o sepdp-cpu sepdp-cpu.c sepdp-misc.o sepdp-keys.o sepdp-file.o $(S3LIB) $(TIMEITLIB)

sepdp-keys.o: sepdp-keys.c sepdp.h
	gcc $(CFLAGS) -c sepdp-keys.c

sepdp-misc.o: sepdp-misc.c sepdp.h
	gcc $(CFLAGS) -c sepdp-misc.c

sepdp-file.o: sepdp-file.c sepdp.h
	gcc $(CFLAGS) -c sepdp-file.c

sepdp-file-cpu: sepdp-file.c sepdp.h
	$(RM) sepdp-file.o; gcc $(CFLAGS) -DCPU_TEST -c sepdp-file.c -o sepdp-file.o

sepdp-s3.o: sepdp-s3.c sepdp.h
	gcc -DUSE_S3 $(CFLAGS) -c sepdp-s3.c

sepdplib: sepdp-core.o sepdp-misc.o sepdp-keys.o sepdp-file.o
	ar -rv sepdplib.a sepdp-misc.o sepdp-keys.o sepdp-file.o

clean:
	rm -rf *.o *.tok sepdp.dSYM sepdp sepdp-s3 sepdp-cpu
