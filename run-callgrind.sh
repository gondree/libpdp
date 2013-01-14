#! /bin/bash
./util/create-buckets.py ;
pushd ./src/apdp ; valgrind --tool=callgrind --callgrind-out-file=../../data/cg-out-apdp.callgrind ./pdp-s3 -3 ../../test-files/testfile_rand_32768KB ; popd ;
pushd ./src/sepdp ; valgrind --tool=callgrind --callgrind-out-file=../../data/cg-out-sepdp.callgrind ./sepdp-s3 -t -y 1 -m 525600 ../../test-files/testfile_rand_32768KB ; popd ;
pushd ./src/macpdp ; valgrind --tool=callgrind --callgrind-out-file=../../data/cg-out-macpdp.callgrind ./por-s3 -t ../../test-files/testfile_rand_32768KB ; popd ;
pushd ./src/cpor ; valgrind --tool=callgrind --callgrind-out-file=../../data/cg-out-cpor.callgrind ./cpor-s3 -t ../../test-files/testfile_rand_32768KB ; popd ;
./util/cleanup-buckets.py ;
