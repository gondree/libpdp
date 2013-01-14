
all: time_it.o
	ar -cvq libtimeit.a time_it.o

time_it.o:
	gcc -g -Wall -fPIC -O0 -c time_it.c 

clean:
	rm -rf *.o *.a
