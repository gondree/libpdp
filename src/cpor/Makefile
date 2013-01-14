
#-finstrument-functions -lSaturn -pg 
# -O3 

CC=gcc
CFLAGS=-g -Wall -O0 -DTIME_IT -I../../lib/libs3-2.0/build/include/ -I../../lib/time_it/
S3LIB = ../../lib/libs3-2.0/build/lib/libs3.a
TIMEITLIB = ../../lib/time_it/libtimeit.a

.PHONY: cpor-file-cpu

all: cpor-misc.o cpor.h cpor-core.o cpor-app.c cpor-file.o cpor-keys.o cpor-app.c 
	$(CC) -Wno-deprecated-declarations $(CFLAGS) -lpthread -lcrypto -o cpor cpor-app.c cpor-core.o cpor-misc.o cpor-file.o cpor-keys.o $(TIMEITLIB)

cpor-s3: cpor-misc.o cpor.h cpor-core.o cpor-app.c cpor-file.o cpor-keys.o cpor-s3.o cpor-app.c 
	$(CC) -DUSE_S3 -Wno-deprecated-declarations $(CFLAGS) -lpthread -lcurl -lxml2 -lz -lcrypto -o cpor-s3 cpor-app.c cpor-misc.o cpor-core.o cpor-file.o cpor-keys.o cpor-s3.o $(S3LIB) $(TIMEITLIB)

cpor-cpu: cpor-misc.o cpor.h cpor-core.o cpor-file-cpu cpor-keys.o cpor-s3.o cpor-cpu.c
	$(CC) -Wno-deprecated-declarations $(CFLAGS) -lpthread -lcurl -lxml2 -lz -lcrypto -o cpor-cpu cpor-cpu.c cpor-misc.o cpor-core.o cpor-file.o cpor-keys.o $(S3LIB) $(TIMEITLIB)

cpor-core.o: cpor-core.c cpor.h
	$(CC) -Wno-deprecated-declarations $(CFLAGS) -c cpor-core.c

cpor-misc.o: cpor-misc.c cpor.h
	$(CC) -Wno-deprecated-declarations $(CFLAGS) -c cpor-misc.c

cpor-file.o: cpor-file.c cpor.h
	$(CC) -Wno-deprecated-declarations $(CFLAGS) -c cpor-file.c

cpor-file-cpu: cpor-file.c cpor.h
	$(RM) cpor-file.o; $(CC) -Wno-deprecated-declarations $(CFLAGS) -DCPU_TEST -c cpor-file.c -o cpor-file.o

cpor-keys.o: cpor-keys.c cpor.h
	$(CC) -Wno-deprecated-declarations $(CFLAGS) -c cpor-keys.c

cpor-s3.o: cpor-s3.c cpor.h
	$(CC) -DUSE_S3 $(CFLAGS) -c cpor-s3.c

cporlib: cpor-core.o cpor-misc.o
	ar -rv cporlib.a cpor-core.o cpor-misc.o

clean:
	rm -rf *.o *.tag *.t cpor.dSYM cpor cpor-s3 cpor-m cpor.key cpor-s3 cpor-cpu
