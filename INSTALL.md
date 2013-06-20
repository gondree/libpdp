## Building

The `libpdp` project has the following significant dependencies:
 
* Library: `libpthread`, `libssl`, [`libs3-2.x`](http://libs3.ischo.com.s3.amazonaws.com/index.html)
* Unit Tests: Python-2.7 +[`boto`](https://github.com/boto/boto) 2.2.2

The following steps are to build on an EC2 Ubuntu 12.07 microimage:

    apt-get update
    apt-get install make g++ git
    apt-get install libcurl3-dev libxml-dev
    apt-get install python-setuptools
    easy_install boto

To build the library `libpdp/libpdp.a`, perform

    make libpdp

### Install
There is no install.

We do not "productize" the code as a shared library because (duh) its not
a production-worthy library, yet. It is proof-of-concept code to 
investigate PDP schemes. See the doxygen notes for numerous deficiencies 
re: protecting secrets and serializing key data. It supports
various hacky/poor-practice methods to load key data from environment
variables, to by-pass appropriate key-protection mechanisms, to do testing and
benchmarking noninteractively. Use the library to protect important data at
your own peril.

A simple bechmarking and testing application exists that uses this library,
under `tools/pdp_bench`, which you can build using `make all`.

----

### libs3
This project distributes copies of `libs3` for conveience. These are covered 
under their own license (GPLv3, see `libs3/LICENSE` for details). 
If the `_S3_SUPPORT` compiler toggle is not defined, `libpdp` is built without
support for S3 as a back-end storage option, and has no dependencies on `libs3`.


### Unit Tests
To run the `libpdp` unit tests, you will need to build `tools/pdp_bench`
and drive the test using a Python-based unit test script:

    ./tools/test.py


### Testing against S3
By default, the S3 unit tests are skipped. To run these, you will need to 
set the 'USE_S3' environment variable, and set some other variables.

    env USE_S3=Yes S3_ACCESS_KEY_ID=<your access key ID> S3_SECRET_ACCESS_KEY=<your secret access key> S3_HOSTNAME=<host:port> ./tools/test.py TestS3Storage

These are credentials to something providing an S3-compatible interface.
Amazon S3 obviously provides such an inteface. Also, DevStack can be run 
locally and provides an appropriate S3-compatible interface. 

Note: *This is not an appropriate way to secure these credentials. 
This is only for testing.*

To see that the remote interface is working
and these environment variables are set correctly,
use the provided utility to talk to the inferface using `boto`:

    ./tools/s3_util.py --ls
    
The above command lists the remote buckets, and is a nice check to
verify that the remote host exists and provides an appropriate 
S3-compatible interface and that your credentials work.


### Benchmarking
The tools to run and analyze the benchmarks can be found under `bench`
To gather performance test data, you must build `tools/pdp_bench`
against a special instrumented version of `libs3` (found under
`tools/lib/libs3-2.0`). This can be done by changing
`tools/Makefile` so that the `S3_LIB` linker variable points
to `$(LIBS3_TIMING)`.

    env S3_ACCESS_KEY_ID=<your access key ID> S3_SECRET_ACCESS_KEY=<your secret access key> S3_HOSTNAME=<host:port> ./bench/run-tests.py --buffer
