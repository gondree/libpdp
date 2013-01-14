
#-finstrument-functions -lSaturn -pg 
CFLAGS=-g -Wall -O0 -DTIME_IT -DDEBUG_MODE -I. -I../../lib/libs3-2.0/build/include -I../../lib/time_it

S3LIB = ../../lib/libs3-2.0/build/lib/libs3.a
TIMEITLIB = ../../lib/time_it/libtimeit.a

all: por-misc.o por.h por-keys.o por-file.o por-app.c
	gcc $(CFLAGS) -lcrypto -pthread -o por por-app.c por-misc.o por-keys.o por-file.o $(TIMEITLIB)

por-s3: por-misc.o por.h por-keys.o por-file.o por-s3.o por-app.c 
	gcc -DUSE_S3 $(CFLAGS) -lcurl -lcrypto -lxml2 -lz -pthread -o por-s3 por-app.c por-misc.o por-keys.o por-file.o por-s3.o $(S3LIB) $(TIMEITLIB)

por-cpu: por-misc.o por.h por-keys.o por-file.o por-cpu.c
	gcc ${CFLAGS} -lcrypto -pthread -o por-cpu por-cpu.c por-file.o por-keys.o por-misc.o $(S3LIB) $(TIMEITLIB)

por-keys.o: por-keys.c por.h
	gcc $(CFLAGS) $(MAKEARGS) -c por-keys.c

por-misc.o: por-misc.c por.h
	gcc $(CFLAGS) $(MAKEARGS) -c por-misc.c

por-file.o: por-file.c por.h
	gcc $(CFLAGS) $(MAKEARGS) -c por-file.c

por-s3.o: por-s3.c por.h
	gcc -DUSE_S3  $(CFLAGS) -c por-s3.c

porlib: por-misc.o por-keys.o por-file.o
	ar -rv porlib.a por-misc.o por-keys.o por-file.o



clean:
	rm -rf *.o por.dSYM por por-s3 *.tag por-s3.dSYM por-s3 por-cpu
