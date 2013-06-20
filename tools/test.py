#!/usr/bin/python

import unittest, subprocess
import re, glob, os, logging, sys, time
import tempfile
from optparse import OptionParser
from subprocess import PIPE
import itertools as iter

###############################################################################

NULL = open(os.devnull,"w")

RSA_ACCESS_KEY = "Z" # fake passphrase for testing

# Some fake parameters for a local DevStack server test environment
S3_BUCKET_NAME = "libpdp_data" # default / testing bucket name
S3_ACCESS_KEY_ID = "XXX"
S3_SECRET_ACCESS_KEY = "YYY"
S3_HOSTNAME = "192.168.99.173:8080"

SCRIPTPATH = os.path.dirname(os.path.abspath(__file__))

TESTFILES = SCRIPTPATH+"/test-files/" # location of generated files
KEYFILES = SCRIPTPATH+"/test-keys/"   # location of saved keys
S3UTIL = SCRIPTPATH+"/s3_util.py"     # a support script for changing buckets
TIME_FILE = TESTFILES + "timing-data.csv"
APP = SCRIPTPATH+"/pdp_bench"

# default parameters
MACPDP = {"alg":'MAC-PDP', "blocksize":4096, "challenges":460}
APDP = {"alg":'APDP', "blocksize":16384, "challenges":460}
CPOR = {"alg":'CPOR', "blocksize":4096, "challenges":80}
SEPDP = {"alg":'SEPDP', "blocksize":4096, "challenges":512}

###############################################################################
""" 
Support Functions 
"""

def subproc(*args, **kwargs):
    """ A wrapper for subprocess.Popen """
    return subprocess.Popen(*args, 
            shell=False, close_fds=True,
            stdout=PIPE, stdin=None, stderr=PIPE,
            **kwargs)

def subcall(*args, **kwargs):
    """A wrapper for subprocess.call"""
    return subprocess.call(*args, 
            shell=False, close_fds=True,
            stdout=NULL, stdin=None, stderr=NULL,
            **kwargs)

def rm_rf(d):
    """ Recursively remove a set of files """
    for path in (os.path.join(d,f) for f in os.listdir(d)):
        if os.path.isdir(path):
            rm_rf(path)
        else:
            os.unlink(path)
    os.rmdir(d)

def rimin(*args):
    """ Rounded integer min """
    return min(int(round(x)) for x in args)

class WrapperTest(unittest.TestCase):
    """ A Support Test Class, other tests inherit """

    def setUp(self):
        if not os.path.exists(TESTFILES):
            os.makedirs(TESTFILES)

    def fillFile(self, len=100):
        """ Fill file with random data """
        if not os.path.exists(TESTFILES):
            os.mkdir(TESTFILES)
        fd, path = tempfile.mkstemp(dir=TESTFILES)
        self.path = path
        os.write(fd, os.urandom(len))
        os.close(fd)

    def emptyFile(self):
        os.unlink(self.path)
        if os.path.exists(self.path):
            os.unlink(self.path)
        if os.path.exists(self.path + ".tag"):
            os.unlink(self.path + ".tag") 
        if os.path.exists(self.path + ".tag.secret"):
            os.unlink(self.path + ".tag.secret") 
        if os.path.exists(TIME_FILE):
            os.unlink(TIME_FILE)

    def output_test(self, args, eout, **kwargs):
        args += ["--timing_output", TIME_FILE]
        pargs = ''.join([x+' ' for x in args])[:-1]
        print "=====> Test case: %s" % (pargs)
        p = subproc(args, **kwargs)
        (out, err) = p.communicate()
        p.wait()
        print "stdout:\n%s" % (out)
        print "stderr:\n%s" % (err)
        for pat in eout:
            print "searching for pattern '%s'" %(pat)
            self.assertRegexpMatches(out, ".*%s*" % pat)
        print "expected empty stderr, got:\n%s" % (err)
        self.assertEquals(err, '')
        print "expected 0, got %s" % (p.returncode)
        self.assertEquals(p.returncode, 0)

    def error_test(self, args, eout, **kwargs):
        pargs = ''.join([x+' ' for x in args])[:-1]
        print "=====> Test case: %s" % (pargs)
        p = subproc(args, **kwargs)
        (out, err) = p.communicate()
        p.wait()
        print "expected msg re: '%s' on stderr, got:\n%s" % (eout, err)
        if (out != ''):
            print "while stdout got:\n%s" %(out)
        print "expected non-zero, got %s" % (p.returncode)
        self.assertNotEquals(p.returncode, 0)

###############################################################################
"""
Tests
"""

class TestBasic(WrapperTest):
    """ Basic test: tagging files of different sizes """    

    def test_fraction_blocks(self):
        """ Fractions of Blocks """
        for alg in [MACPDP, APDP, CPOR, SEPDP]:
            blocksize = alg["blocksize"]
            for num in [0.5, 1, 2, 2.5, 3.5]:
                self.fillFile(int(blocksize * num))
                self.output_test([APP, "-a", alg["alg"], "-f", self.path,
                                  "-v", "-T", "-C", "-P", "-V"],
                                 ["File Integrity: Yes",
                                  "Filename: %s" %(self.path),
                                  "Num challenges: %d" %(rimin(num)),
                                  "Num blocks: %d" %(rimin(num))])
                self.emptyFile()

    def test_many_blocks(self):
        """ Files of large sizes """
        for alg in [MACPDP, APDP, CPOR, SEPDP]:
            blocksize = alg["blocksize"]
            challenges = alg["challenges"]
            for num in [0.5*challenges, 2.2*challenges, 5*challenges]:
                self.fillFile(int(blocksize * num))
                self.output_test([APP, "-a", alg["alg"], "-f", self.path,
                                  "-v", "-T", "-C", "-P", "-V"],
                                 ["File Integrity: Yes",
                                  "Filename: %s" %(self.path),
                                  "Num challenges: %d" 
                                    %(rimin(alg["challenges"], num)),
                                  "Num blocks: %d" %(rimin(num))])
                self.emptyFile()


class TestOps(WrapperTest):
    """ Basic test: different combinations of operations """    

    def test_TCP(self):
        """ Check no -V  """
        for alg in [MACPDP, APDP, CPOR, SEPDP]:
            blocksize = alg["blocksize"]
            challenges = alg["challenges"]
            for num in [0.5, 1, 2*challenges]:
                self.fillFile(int(blocksize * num))
                self.output_test([APP, "-a", alg["alg"], "-f", self.path,
                                  "-v", "-T", "-C", "-P"],
                                 ["Filename: %s" %(self.path)])
                self.emptyFile()

    def test_TCV(self):
        """ Check no -P  """
        for alg in [MACPDP, APDP, CPOR, SEPDP]:
            blocksize = alg["blocksize"]
            challenges = alg["challenges"]
            for num in [0.5, 1, 2*challenges]:
                self.fillFile(int(blocksize * num))
                self.output_test([APP, "-a", alg["alg"], "-f", self.path,
                                  "-v", "-T", "-C", "-V"],
                                 ["Filename: %s" %(self.path)])
                self.emptyFile()

    def test_TC(self):
        """ Check no -P or -V  """
        for alg in [MACPDP, APDP, CPOR, SEPDP]:
            blocksize = alg["blocksize"]
            challenges = alg["challenges"]
            for num in [0.5, 1, 2*challenges]:
                self.fillFile(int(blocksize * num))
                self.output_test([APP, "-a", alg["alg"], "-f", self.path,
                                  "-v", "-T", "-C"],
                                 ["Filename: %s" %(self.path)])
                self.emptyFile()

    def test_T(self):
        """ Check no -C or -P or -V  """
        for alg in [MACPDP, APDP, CPOR, SEPDP]:
            blocksize = alg["blocksize"]
            challenges = alg["challenges"]
            for num in [0.5, 1, 2*challenges]:
                self.fillFile(int(blocksize * num))
                self.output_test([APP, "-a", alg["alg"], "-f", self.path,
                                  "-v", "-T"],
                                 ["Filename: %s" %(self.path)])
                self.emptyFile()

    def test_None(self):
        """ Check no ops  """
        for alg in [MACPDP, APDP, CPOR, SEPDP]:
            blocksize = alg["blocksize"]
            challenges = alg["challenges"]
            for num in [0.5, 1, 2*challenges]:
                self.fillFile(int(blocksize * num))
                self.output_test([APP, "-a", alg["alg"], "-f", self.path,
                                  "-v"],
                                 ["Filename: %s" %(self.path)])
                self.emptyFile()


class TestThreaded(WrapperTest):
    """ Basic test: tagging with and without threads """    

    def test_explicit_threads(self):
        """ Files of large sizes """
        for alg in [MACPDP, APDP, CPOR, SEPDP]:
            blocksize = alg["blocksize"]
            challenges = alg["challenges"]
            for num in [0.5, 1, 2, 2.5, 3.5, 0.5*challenges, 
                        2.2*challenges, 5*challenges]:
                self.fillFile(int(blocksize * num))
                self.output_test([APP, "-a", alg["alg"], "-f", self.path,
                                  "-v", "-T", "-C", "-P", "-V",
                                  "--numthreads", "20"], 
                                 ["File Integrity: Yes",
                                  "Filename: %s" %(self.path),
                                  "Num challenges: %d" 
                                    %(rimin(alg["challenges"], num)),
                                  "Num blocks: %d" %(rimin(num))])
                self.emptyFile()

    def test_no_threads(self):
        """ Files of large sizes """
        for alg in [MACPDP, APDP, CPOR, SEPDP]:
            blocksize = alg["blocksize"]
            challenges = alg["challenges"]
            for num in [0.5, 1, 2, 2.5, 3.5, 0.5*challenges, 
                        2.2*challenges, 5*challenges]:
                self.fillFile(int(blocksize * num))
                self.output_test([APP, "-a", alg["alg"], "-f", self.path,
                                  "-v", "-T", "-C", "-P", "-V",
                                  "--numthreads", "1"], 
                                 ["File Integrity: Yes",
                                  "Filename: %s" %(self.path),
                                  "Num challenges: %d" 
                                    %(rimin(alg["challenges"], num)),
                                  "Num blocks: %d" %(rimin(num))])
                self.emptyFile()


class TestStoredKeys(WrapperTest):
    """ Testing different operations using stored keys """

    @unittest.skip("This test is not portable")
    def test_read_keyfile_apdp(self):
        """ Use a stored key and (non-interactive) password """
        for alg in [APDP, CPOR]:
            blocksize = alg["blocksize"]
            for num in [0.5, 1, 2, 2.5, 3.5]:
                self.fillFile(int(blocksize * num))
                self.output_test([APP, "-a", alg["alg"], "-f", self.path,
                                  "-v", "-T", "-C", "-P", "-V",
                                  "-k", KEYFILES, "--noninteractive"], 
                                 ["File Integrity: Yes"],
                                  env={"RSA_ACCESS_KEY":RSA_ACCESS_KEY})
                self.emptyFile()

    def test_gen_keyfile_apdp(self):
        """ Generate and store new key files """
        for alg in [APDP, CPOR]:
            blocksize = alg["blocksize"]
            newtestdir = TESTFILES + "new/"
            for num in [1]:
                self.fillFile(int(blocksize * num))
                self.output_test([APP, "-a", alg["alg"], "-f", self.path,
                                  "-v", "-T", "-C", "-P", "-V",
                                  "-k", newtestdir, "--noninteractive"], 
                                 ["File Integrity: Yes"],
                                  env={"RSA_ACCESS_KEY":RSA_ACCESS_KEY})
                self.emptyFile()
                rm_rf(newtestdir)

    def test_tag_then_challenge_apdp(self):
        """ Gen key file, Tag, then later Challenge """
        for alg in [APDP, CPOR]:
            blocksize = alg["blocksize"]
            newtestdir = TESTFILES + "new/"
            self.fillFile(int(blocksize * 50))
            self.output_test([APP, "-a", alg["alg"], "-f", self.path,
                              "-v", "-k", newtestdir, "--noninteractive"],
                             ["Generating keys...Done"],
                              env={"RSA_ACCESS_KEY":RSA_ACCESS_KEY})
            self.output_test([APP, "-a", alg["alg"], "-f", self.path,
                              "-v", "-T",
                              "-k", newtestdir, "--noninteractive"],
                             ["Storing tag and file data...Done."],
                              env={"RSA_ACCESS_KEY":RSA_ACCESS_KEY})
            self.output_test([APP, "-a", alg["alg"], "-f", self.path,
                              "-v", "-C", "-P", "-V",
                              "-k", newtestdir, "--noninteractive"], 
                             ["File Integrity: Yes"],
                              env={"RSA_ACCESS_KEY":RSA_ACCESS_KEY})
            self.emptyFile()
            rm_rf(newtestdir)


@unittest.skipUnless('USE_S3' in os.environ, "requires S3 interface")
class TestS3Storage(WrapperTest):
    """ A test that uses S3 as a storage backend """

    def setUp(self):
        global S3_ACCESS_KEY_ID, S3_SECRET_ACCESS_KEY, S3_HOSTNAME
        """ Prepare for running test """
        if 'S3_ACCESS_KEY_ID' in os.environ:
            S3_ACCESS_KEY_ID = os.environ['S3_ACCESS_KEY_ID']
        if 'S3_SECRET_ACCESS_KEY' in os.environ:
            S3_SECRET_ACCESS_KEY = os.environ['S3_SECRET_ACCESS_KEY']
        if 'S3_HOSTNAME' in os.environ:
            S3_HOSTNAME = os.environ['S3_HOSTNAME']
        subcall([S3UTIL, "--mk", S3_BUCKET_NAME],
                env={"S3_ACCESS_KEY_ID":S3_ACCESS_KEY_ID,
                     "S3_SECRET_ACCESS_KEY":S3_SECRET_ACCESS_KEY,
                     "S3_HOSTNAME":S3_HOSTNAME})

    def tearDown(self):
        """ Teardown test set-up """
        subcall([S3UTIL, "--rm", S3_BUCKET_NAME],
                env={"S3_ACCESS_KEY_ID":S3_ACCESS_KEY_ID,
                     "S3_SECRET_ACCESS_KEY":S3_SECRET_ACCESS_KEY,
                     "S3_HOSTNAME":S3_HOSTNAME})

    def test_TCPV_s3(self):
        """ Use S3 as tag storage """
        for alg in [MACPDP, APDP, CPOR, SEPDP]:
            blocksize = alg["blocksize"]
            for num in [0.5, 1, 2, 2.5, 3.5]:
                self.fillFile(int(blocksize * num))
                self.output_test([APP, "-a", alg["alg"], "-f", self.path,
                                  "-v", "-T", "-C", "-P", "-V", "-3"],
                                 ["File Integrity: Yes",
                                  "Num blocks: %d" %(rimin(num))],
                          env={"RSA_ACCESS_KEY":RSA_ACCESS_KEY,
                               "S3_ACCESS_KEY_ID":S3_ACCESS_KEY_ID,
                               "S3_SECRET_ACCESS_KEY":S3_SECRET_ACCESS_KEY,
                               "S3_HOSTNAME":S3_HOSTNAME})
                self.emptyFile()


class TestParams(WrapperTest):
    """ Test errors related to calling with bad params """

    def test_no_alg(self):
        self.fillFile(100)
        for p in ["-a", "--algo"]:
            self.error_test([APP, p, "-f", self.path, "-v"],
                             "no algo arg")
        self.emptyFile()

    def test_no_file(self):
        for p in ["-a", "--algo"]:
            for alg in [MACPDP, APDP, CPOR, SEPDP]:
                self.error_test([APP, p, alg["alg"], "-v"],
                                 "no filename arg")

    def test_params(self):
        """ Test the -x  and --x versions of each param """
        for p, f in iter.product(["-a", "--algo"], ["-f", "--filename"]):
            for alg in [MACPDP, APDP, CPOR, SEPDP]:
                self.fillFile(100)
                self.output_test([APP, p, alg["alg"], "-v",
                                  "-T", "-C", "-P", "-V", f, self.path],
                                 ["File Integrity: Yes"])
                self.emptyFile()


###############################################################################
#
# Main
#
if __name__=="__main__":
    print >> sys.stderr, "--------> Testing '%s'" % ("pdp_bench")
    unittest.main(buffer=True)
    exit(0);

