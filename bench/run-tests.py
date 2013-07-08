#!/usr/bin/python

import os, shlex, logging, unittest
import math, time, datetime, boto
from boto.s3.connection import S3Connection
from boto.s3.connection import OrdinaryCallingFormat
from subprocess import call, Popen, PIPE
from time import time
import itertools as iter
import inspect

###############################################################################
# constants

NULL = open(os.devnull,"w")

SCRIPTPATH = os.path.dirname(os.path.abspath(__file__))
app = SCRIPTPATH+"/../tools/pdp_bench"
testdir = SCRIPTPATH+"/files/"
tmpdir = SCRIPTPATH+"/tmp/"
datadir = SCRIPTPATH+"/data/"
logdir = SCRIPTPATH+"/log/"

input_pattern = "input.testfile_rand_"
output_pattern = "_output."

buckets = ["libpdp_data"]
trials = 3
nthread = "4"

RSA_ACCESS_KEY = "Z" # fake passphrase for testing

# Some fake parameters for a local DevStack server test environment
S3_BUCKET_NAME = "libpdp_data" # default / testing bucket name
S3_ACCESS_KEY_ID = "XXX"
S3_SECRET_ACCESS_KEY = "YYY"
S3_HOSTNAME = "192.168.99.173:8080"

test_env = {}
Id = None
Key = None
Host = None
Port = None

###############################################################################
# default parameters

MACPDP = {"alg":'MAC-PDP', "blocksize":'4096', "challenges":'460', "args":[]}
APDP = {"alg":'APDP', "blocksize":'4096', "challenges":'460', "args":[]}
CPOR = {"alg":'CPOR', "blocksize":'4096', "challenges":'80', "args":[]}
SEPDP = {"alg":'SEPDP', "blocksize":'4096', "challenges":'460', 
         "args":["--year", "1", "--minutes", "525600"]}
SCHEMES = [MACPDP, APDP, CPOR, SEPDP]


all_file_sizes = [str(2**i)+"KB" for i in range(1,21)]
all_block_sizes = [str(2**i) for i in range(10,21)]


###############################################################################

def subproc(*args, **kwargs):
    """ A wrapper for Popen """
    return Popen(*args, shell=False, close_fds=True, **kwargs)


class PdpExperiment(unittest.TestCase):
    """ A Support Test Class, other tests inherit """

    def setup_files(self):
        """ generate files with random contents (caching, because these
            can be useful in other tests)"""
        self.inputs = []
        self.outputs = []
        self.inputs_by_size = {}

        for sz in all_file_sizes:
            file = testdir + input_pattern + sz
            if not os.path.exists(file):
                cmd = ["dd", "if=/dev/urandom", 
                       "of="+file, "bs=1KB", "count="+sz.strip('KB')]
                print ' '.join(cmd)
                p = call(cmd)
                self.assertEquals(p, 0)
            self.inputs.append(file)
            self.inputs_by_size[sz] = file

    def remove_tags(self):
        call(["rm", "-f", testdir+"*.tag"])
        call(["rm", "-f", testdir+"*.tag.secret"])

    def store_results(self):
        """ move data files """
        if not os.path.exists(datadir):
            os.mkdir(datadir)
        for file in self.outputs:
            cmd = ["mv", file, datadir]
            logger.info(" ".join(cmd))
            call(cmd, stdout=NULL, stderr=NULL)


class PdpS3Experiment(PdpExperiment):
    """ A Support Test Class, other tests inherit """

    def setUp(self):
        self.check_s3()
        self.setup_s3()
        self.setup_files()

    def tearDown(self):
        self.store_results()
        self.remove_tags()
        self.delete_buckets()

    def check_s3(self):
        """ check S3 test is able to be run """
        self.assertNotEqual(Id, None)
        self.assertNotEqual(Key, None)
        self.assertNotEqual(Host, None)
        self.assertNotEqual(Port, None)

    def setup_s3(self):
        """ make the buckets """
        self.conn = boto.connect_s3(Id, Key, host=Host, port=Port, 
                    is_secure=False, calling_format=OrdinaryCallingFormat())
        for b in buckets:
            try:
                logger.info("Creating %s" % b)
                self.conn.create_bucket(b)
            except:
                logger.info("Couldn't create bucket %s" % b)

    def cleanup_buckets(self):
        """ empty buckets """
        for b in buckets:
            try:
                bo = self.conn.get_bucket(b)
                keys = bo.get_all_keys()
                for k in keys:
                    bo.delete_key(k)
            except:
                logger.info("The bucket %s couldn't be emptied." % b)

    def delete_buckets(self):
        """ delete buckets """
        for b in buckets:
            try:
                logger.info("Deleting %s" % b)
                bo = self.conn.get_bucket(b)
                keys = bo.get_all_keys()
                for k in keys:
                    bo.delete_key(k)
                self.conn.delete_bucket(b)
            except:
                logger.info("The bucket %s couldn't be deleted." % b)


class TestSepdpExperiments(PdpS3Experiment):

    def test_sepdp_minutes(self):
        """ run tests for SEPDP """
        fn = inspect.stack()[0][3]
        output = tmpdir + str(time()) + output_pattern + fn + ".csv"
        args = ["-T","-C","-P","-V"]
        inputs = [self.inputs_by_size["32768KB"]]
        mins = range(60,365*24*60,60)
        s = SEPDP
        for file, min in iter.product(inputs, mins):
            for i in range(trials):
                cmd = [app, "--algo", s["alg"], 
                            "--blocksize", s["blocksize"], 
                            "--cparam", s["challenges"],
                            "--filename", file, 
                            "--timing_output", output, 
                            "--year", "1", "--minutes", str(min)] + args
                logger.info(" ".join(cmd))
                p = subproc(cmd, stdout=PIPE, stderr=PIPE, env=test_env)
                (out, err) = p.communicate()
                p.wait()
                if p.returncode != 0:
                    logger.error(out)
                    logger.error(err)
                self.cleanup_buckets()
                self.remove_tags()
        self.outputs.append(output)


class TestAllSchemesLocal(PdpS3Experiment):

    def test_all_file_sizes(self):
        """ run tests across all file sizes """
        fn = inspect.stack()[0][3]
        output = tmpdir + str(time()) + output_pattern + fn + ".csv"
        args = ["--numthreads",nthread,"-T","-C","-P","-V"]
        inputs = self.inputs
        for s, file in iter.product(SCHEMES, inputs):
            for i in range(trials):
                cmd = [app, "--algo", s["alg"], 
                            "--blocksize", s["blocksize"], 
                            "--cparam", s["challenges"],
                            "--filename", file, 
                            "--timing_output", output] + s["args"] + args
                logger.info(" ".join(cmd))
                p = subproc(cmd, stdout=PIPE, stderr=PIPE, env=test_env)
                (out, err) = p.communicate()
                p.wait()
                if p.returncode != 0:
                    logger.error(out)
                    logger.error(err)
                self.cleanup_buckets()
                self.remove_tags()
        self.outputs.append(output)

    def test_all_file_sizes_no_threads(self):
        """ run tests across all file sizes """
        fn = inspect.stack()[0][3]
        output = tmpdir + str(time()) + output_pattern + fn + ".csv"
        args = ["--numthreads","1","-T","-C","-P","-V"]
        inputs = self.inputs
        for s, file in iter.product(SCHEMES, inputs):
            for i in range(trials):
                cmd = [app, "--algo", s["alg"], 
                            "--blocksize", s["blocksize"],
                            "--cparam", s["challenges"],
                            "--filename", file, 
                            "--timing_output", output] + s["args"] + args
                logger.info(" ".join(cmd))
                p = subproc(cmd, stdout=PIPE, stderr=PIPE, env=test_env)
                (out, err) = p.communicate()
                p.wait()
                if p.returncode != 0:
                    logger.error(out)
                    logger.error(err)
                self.cleanup_buckets()
                self.remove_tags()
        self.outputs.append(output)

    def test_all_file_sizes_no_threads_loop(self):
        """ run tests across all file sizes """
        fn = inspect.stack()[0][3]
        output = tmpdir + str(time()) + output_pattern + fn + ".csv"
        args = ["--numthreads","1","-T","-C","-P","-V","--cpu","10"]
        inputs = self.inputs
        for s, file in iter.product(SCHEMES, inputs):
            for i in range(trials):
                cmd = [app, "--algo", s["alg"], 
                            "--blocksize", s["blocksize"],
                            "--cparam", s["challenges"],
                            "--filename", file, 
                            "--timing_output", output] + s["args"] + args
                logger.info(" ".join(cmd))
                p = subproc(cmd, stdout=PIPE, stderr=PIPE, env=test_env)
                (out, err) = p.communicate()
                p.wait()
                if p.returncode != 0:
                    logger.error(out)
                    logger.error(err)
                self.cleanup_buckets()
                self.remove_tags()
        self.outputs.append(output)

    def test_all_block_sizes(self):
        """ run tests across all file sizes """
        fn = inspect.stack()[0][3]
        output = tmpdir + str(time()) + output_pattern + fn + ".csv"
        args = ["--numthreads",nthread,"-T","-C","-P","-V"]
        inputs = [self.inputs_by_size["32768KB"]]
        blocks = all_block_sizes
        for s, bs, file in iter.product(SCHEMES, blocks, inputs):
            for i in range(trials):
                cmd = [app, "--algo", s["alg"], 
                            "--blocksize", str(bs),
                            "--cparam", s["challenges"],
                            "--filename", file, 
                            "--timing_output", output] + s["args"] + args
                logger.info(" ".join(cmd))
                p = subproc(cmd, stdout=PIPE, stderr=PIPE, env=test_env)
                (out, err) = p.communicate()
                p.wait()
                if p.returncode != 0:
                    logger.error(out)
                    logger.error(err)
                self.cleanup_buckets()
                self.remove_tags()
        self.outputs.append(output)

    def test_all_block_sizes_no_threads(self):
        """ run tests across all file sizes """
        fn = inspect.stack()[0][3]
        output = tmpdir + str(time()) + output_pattern + fn + ".csv"
        args = ["--numthreads","1","-T","-C","-P","-V"]
        inputs = [self.inputs_by_size["32768KB"]]
        blocks = all_block_sizes
        for s, bs, file in iter.product(SCHEMES, blocks, inputs):
            for i in range(trials):
                cmd = [app, "--algo", s["alg"], 
                            "--blocksize", str(bs),
                            "--cparam", s["challenges"],
                            "--filename", file, 
                            "--timing_output", output] + s["args"] + args
                logger.info(" ".join(cmd))
                p = subproc(cmd, stdout=PIPE, stderr=PIPE, env=test_env)
                (out, err) = p.communicate()
                p.wait()
                if p.returncode != 0:
                    logger.error(out)
                    logger.error(err)
                self.cleanup_buckets()
                self.remove_tags()
        self.outputs.append(output)

    def test_all_block_sizes_no_threads_loop(self):
        """ run tests across all file sizes """
        fn = inspect.stack()[0][3]
        output = tmpdir + str(time()) + output_pattern + fn + ".csv"
        args = ["--numthreads","1","-T","-C","-P","-V","--cpu", "10"]
        inputs = [self.inputs_by_size["32768KB"]]
        blocks = all_block_sizes
        for s, bs, file in iter.product(SCHEMES, blocks, inputs):
            for i in range(trials):
                cmd = [app, "--algo", s["alg"], 
                            "--blocksize", str(bs),
                            "--cparam", s["challenges"],
                            "--filename", file, 
                            "--timing_output", output] + s["args"] + args
                logger.info(" ".join(cmd))
                p = subproc(cmd, stdout=PIPE, stderr=PIPE, env=test_env)
                (out, err) = p.communicate()
                p.wait()
                if p.returncode != 0:
                    logger.error(out)
                    logger.error(err)
                self.cleanup_buckets()
                self.remove_tags()
        self.outputs.append(output)

class TestAllSchemes(PdpS3Experiment):

    def test_all_file_sizes_s3(self):
        """ run tests across all file sizes """
        fn = inspect.stack()[0][3]
        output = tmpdir + str(time()) + output_pattern + fn + ".csv"
        args = ["--numthreads",nthread,"-3", "-T","-C","-P","-V"]
        inputs = self.inputs
        for s, file in iter.product(SCHEMES, inputs):
            for i in range(trials):
                cmd = [app, "--algo", s["alg"], 
                            "--blocksize", s["blocksize"], 
                            "--cparam", s["challenges"],
                            "--filename", file, 
                            "--timing_output", output] + s["args"] + args
                logger.info(" ".join(cmd))
                p = subproc(cmd, stdout=PIPE, stderr=PIPE, env=test_env)
                (out, err) = p.communicate()
                p.wait()
                if p.returncode != 0:
                    logger.error(out)
                    logger.error(err)
                self.cleanup_buckets()
                self.remove_tags()
        self.outputs.append(output)

    def test_all_file_sizes_no_threads_s3(self):
        """ run tests across all file sizes """
        fn = inspect.stack()[0][3]
        output = tmpdir + str(time()) + output_pattern + fn + ".csv"
        args = ["--numthreads","1","-3", "-T","-C","-P","-V"]
        inputs = self.inputs
        for s, file in iter.product(SCHEMES, inputs):
            for i in range(trials):
                cmd = [app, "--algo", s["alg"], 
                            "--blocksize", s["blocksize"],
                            "--cparam", s["challenges"],
                            "--filename", file, 
                            "--timing_output", output] + s["args"] + args
                logger.info(" ".join(cmd))
                p = subproc(cmd, stdout=PIPE, stderr=PIPE, env=test_env)
                (out, err) = p.communicate()
                p.wait()
                if p.returncode != 0:
                    logger.error(out)
                    logger.error(err)
                self.cleanup_buckets()
                self.remove_tags()
        self.outputs.append(output)

    def test_all_block_sizes_s3(self):
        """ run tests across all file sizes """
        fn = inspect.stack()[0][3]
        output = tmpdir + str(time()) + output_pattern + fn + ".csv"
        args = ["--numthreads",nthread,"-3","-T","-C","-P","-V"]
        inputs = [self.inputs_by_size["32768KB"]]
        blocks = all_block_sizes
        for s, bs, file in iter.product(SCHEMES, blocks, inputs):
            for i in range(trials):
                cmd = [app, "--algo", s["alg"], 
                            "--blocksize", str(bs),
                            "--cparam", s["challenges"],
                            "--filename", file, 
                            "--timing_output", output] + s["args"] + args
                logger.info(" ".join(cmd))
                p = subproc(cmd, stdout=PIPE, stderr=PIPE, env=test_env)
                (out, err) = p.communicate()
                p.wait()
                if p.returncode != 0:
                    logger.error(out)
                    logger.error(err)
                self.cleanup_buckets()
                self.remove_tags()
        self.outputs.append(output)

    def test_all_block_sizes_no_threads_s3(self):
        """ run tests across all file sizes """
        fn = inspect.stack()[0][3]
        output = tmpdir + str(time()) + output_pattern + fn + ".csv"
        args = ["--numthreads","1","-3","-T","-C","-P","-V"]
        inputs = [self.inputs_by_size["32768KB"]]
        blocks = all_block_sizes
        for s, bs, file in iter.product(SCHEMES, blocks, inputs):
            for i in range(trials):
                cmd = [app, "--algo", s["alg"], 
                            "--blocksize", str(bs),
                            "--cparam", s["challenges"],
                            "--filename", file, 
                            "--timing_output", output] + s["args"] + args
                logger.info(" ".join(cmd))
                p = subproc(cmd, stdout=PIPE, stderr=PIPE, env=test_env)
                (out, err) = p.communicate()
                p.wait()
                if p.returncode != 0:
                    logger.error(out)
                    logger.error(err)
                self.cleanup_buckets()
                self.remove_tags()
        self.outputs.append(output)

class TestAllSchemesCpu(PdpS3Experiment):

    @unittest.skipUnless('CALLGRIND' in os.environ, "non-performance test")
    def test_all_file_sizes_callgrind(self):
        """ gather data using callgrind """
        fn = inspect.stack()[0][3]
        output = tmpdir + str(time()) + output_pattern + fn + ".csv"
        args = ["--numthreads",nthread,"-3","-T","-C","-P","-V","--cpu","10"]
        inputs = self.inputs
        for s, file in iter.product(SCHEMES, inputs):
            for i in range(1):
                cg_out = datadir+str(time())+'_'+s["alg"]+".callgrind"
                cmd = ["valgrind", "--tool=callgrind",
                            "--callgrind-out-file=%s" %(cg_out),
                       app, "--algo", s["alg"], 
                            "--blocksize", s["blocksize"], 
                            "--cparam", s["challenges"],
                            "--filename", file, 
                            "--timing_output", output] + s["args"] + args
                logger.info(" ".join(cmd))
                p = subproc(cmd, stdout=PIPE, stderr=PIPE, env=test_env)
                (out, err) = p.communicate()
                p.wait()
                if p.returncode != 0:
                    logger.error(out)
                    logger.error(err)
                self.cleanup_buckets()
                self.remove_tags()
        self.outputs.append(output)

    @unittest.skipUnless('CALLGRIND' in os.environ, "non-performance test")
    def test_all_block_sizes_callgrind(self):
        """ gather data using callgrind """
        fn = inspect.stack()[0][3]
        output = tmpdir + str(time()) + output_pattern + fn + ".csv"
        args = ["--numthreads",nthread,"-3","-T","-C","-P","-V","--cpu","10"]
        inputs = [self.inputs_by_size["32768KB"]]
        blocks = all_block_sizes
        for s, bs, file in iter.product(SCHEMES, blocks, inputs):
            for i in range(1):
                cg_out = datadir+str(time())+'_'+s["alg"]+".callgrind"
                cmd = ["valgrind", "--tool=callgrind",
                            "--callgrind-out-file=%s" %(cg_out),
                       app, "--algo", s["alg"], 
                            "--blocksize", str(bs), 
                            "--cparam", s["challenges"],
                            "--filename", file, 
                            "--timing_output", output] + s["args"] + args
                logger.info(" ".join(cmd))
                p = subproc(cmd, stdout=PIPE, stderr=PIPE, env=test_env)
                (out, err) = p.communicate()
                p.wait()
                if p.returncode != 0:
                    logger.error(out)
                    logger.error(err)
                self.cleanup_buckets()
                self.remove_tags()
        self.outputs.append(output)

    def test_all_file_sizes_cpu(self):
        """ run tests in a loop to gather timing data for operations """
        fn = inspect.stack()[0][3]
        output = tmpdir + str(time()) + output_pattern + fn + ".csv"
        args = ["--numthreads",nthread,"-3","-T","-C","-P","-V","--cpu","10"]
        inputs = self.inputs
        for s, file in iter.product(SCHEMES, inputs):
            for i in range(trials):
                cmd = [app, "--algo", s["alg"], 
                            "--blocksize", s["blocksize"], 
                            "--cparam", s["challenges"],
                            "--filename", file, 
                            "--timing_output", output] + s["args"] + args
                logger.info(" ".join(cmd))
                p = subproc(cmd, stdout=PIPE, stderr=PIPE, env=test_env)
                (out, err) = p.communicate()
                p.wait()
                if p.returncode != 0:
                    logger.error(out)
                    logger.error(err)
                self.cleanup_buckets()
                self.remove_tags()
        self.outputs.append(output)


    def test_all_block_sizes_cpu(self):
        """ run tests in a loop to gather timing data for operations """
        fn = inspect.stack()[0][3]
        output = tmpdir + str(time()) + output_pattern + fn + ".csv"
        args = ["--numthreads",nthread,"-3","-T","-C","-P","-V","--cpu","10"]
        inputs = [self.inputs_by_size["32768KB"]]
        blocks = all_block_sizes
        for s, bs, file in iter.product(SCHEMES, blocks, inputs):
            for i in range(trials):
                cmd = [app, "--algo", s["alg"], 
                            "--blocksize", str(bs),
                            "--cparam", s["challenges"],
                            "--filename", file, 
                            "--timing_output", output] + s["args"] + args
                logger.info(" ".join(cmd))
                p = subproc(cmd, stdout=PIPE, stderr=PIPE, env=test_env)
                (out, err) = p.communicate()
                p.wait()
                if p.returncode != 0:
                    logger.error(out)
                    logger.error(err)
                self.cleanup_buckets()
                self.remove_tags()
        self.outputs.append(output)



###############################################################################
#
# Main
#
if __name__=="__main__":
    if 'S3_ACCESS_KEY_ID' in os.environ:
        S3_ACCESS_KEY_ID = os.environ['S3_ACCESS_KEY_ID']
    if 'S3_SECRET_ACCESS_KEY' in os.environ:
        S3_SECRET_ACCESS_KEY = os.environ['S3_SECRET_ACCESS_KEY']
    if 'S3_HOSTNAME' in os.environ:
        S3_HOSTNAME  = os.environ['S3_HOSTNAME']

    test_env = {"RSA_ACCESS_KEY":S3_SECRET_ACCESS_KEY,
                "S3_ACCESS_KEY_ID":S3_ACCESS_KEY_ID,
                "S3_SECRET_ACCESS_KEY":S3_SECRET_ACCESS_KEY,
                "S3_HOSTNAME":S3_HOSTNAME,
                "RSA_ACCESS_KEY":RSA_ACCESS_KEY}

    Id = test_env["S3_ACCESS_KEY_ID"]
    Key = test_env["S3_SECRET_ACCESS_KEY"]
    Host, Port = test_env["S3_HOSTNAME"].split(':')
    Port = int(Port)

    if not os.path.exists(testdir):
        os.mkdir(testdir)
    if not os.path.exists(tmpdir):
        os.mkdir(tmpdir)
    if not os.path.exists(datadir):
        os.mkdir(datadir)
    if not os.path.exists(logdir):
        os.mkdir(logdir)

    logger = logging.getLogger('libpdpPerf')
    hdlr = logging.FileHandler(logdir + str(datetime.date.today()))
    formatter = logging.Formatter('%(asctime)s %(levelname)s %(message)s')
    hdlr.setFormatter(formatter)
    logger.addHandler(hdlr) 
    logger.setLevel(logging.INFO)

    unittest.main(buffer=True)
    exit(0);
