#!/usr/bin/python
import boto
from boto.s3.connection import S3Connection
import os
from boto.s3.connection import OrdinaryCallingFormat
from subprocess import call
from subprocess import Popen
import shlex

exp_count = 1
test_fname_pat = "test-files/testfile_rand_"

cpor = "./src/cpor/cpor-s3"
macpdp = "./src/por/por-s3"
sepdp = "./src/sepdp/sepdp-s3"
apdp = "./src/pdp/pdp-s3"

times_dir = "./data/all-times-file-size-no-threads"

methodologies = [
	dict(path=cpor, args="-h 1 -t"),
	dict(path=macpdp, args="-h 1 -t"),
	dict(path=sepdp, args="-h 1 -t -y 5 -m 525600"),
	dict(path=apdp, args="-h 1 -3")
]

# File sizes to be used
file_sizes = []
for i in range(1,21):
	file_sizes.append(str(2**i)+"KB")
file_sizes.append(str(2**15)+"KB")

block_sizes = []
block_sizes.append("4096")

buckets = ["cpor","macpdp","apdp","sepdp"]

Id = os.environ['S3_ACCESS_KEY_ID']
Key = os.environ['S3_SECRET_ACCESS_KEY']
Host, Port = os.environ['S3_HOSTNAME'].split(':')
Port = int(Port)

#####################

conn = boto.connect_s3(
	Id,
	Key,
	host=Host,
	port=Port,
	is_secure=False,
	calling_format=OrdinaryCallingFormat())

# Make all the buckets
for b in buckets:
	try:
		print "Creating %s" % b
		conn.create_bucket(b)
	except:
		print "Couldn't create bucket %s" % b

# Generate files with random contents
# Caching, because this can take a while
test_file_dir = test_fname_pat.split("/")[0]
try:
	print "Generating test files"
	# TODO Make more better. This is where we fail if cached, not very flexible
	os.mkdir(test_fname_pat.split("/")[0]) 
	dd_cmd = ["dd", "if=/dev/urandom"]
	for sz in file_sizes:
		try:
			call(dd_cmd+["of="+test_fname_pat+sz, "bs="+sz, "count=1"])
		except:
			print "Test file creation failed"
except:
	# We can expect this to fail if the files are present
	print "Test files already cached"

# Call each methodology, redirect output, unbuffered
out = open("./log/exp_output", 'w', 0)
for b_sz in block_sizes:
	for sz in file_sizes:
		for method in methodologies:
			for i in range(exp_count):
				mlist = os.path.split(method["path"])

				cmd = ["cd ./"+mlist[0]+" ; ./"
							+mlist[1]+" "+method["args"]+" -b "+b_sz+" ../"
							+test_fname_pat+sz+"; cd ../"
							+test_file_dir+"; rm -f *.tag *.tok *.t"]

				out.write("\n\n"+method["path"]+"\n"+cmd[0]+"\n\n")

				try:
					p = Popen(cmd, stdout=out, stderr=out, shell=True)
					p.wait()
					print "Finished "+cmd[0]+"...",
					# Cleanup so we don't run out of disk space
					bucket_name = mlist[1].split('-')[0]
					bo = conn.get_bucket(bucket_name)
					keys = bo.get_all_keys()
					for k in keys:
						try:
							print "Deleting %s" % str(bucket_name+"/"+k.name),
							bo.delete_key(k)
						except:
							print "The file %s couldn't be deleted." % str(bucket_name+"/"+k.name)
					print ''
				except Exception,e:
					print "Couldn't execute "+cmd[0]+" "+str(e)
out.close()

for b in buckets:
	try:
		print "Deleting %s" % b
		bo = conn.get_bucket(b)
		keys = bo.get_all_keys()
		for k in keys:
			bo.delete_key(k)
		conn.delete_bucket(b)
	except:
		print "The bucket %s couldn't be deleted." % b

times = []
for method in methodologies:
	try:
		os.mkdir(times_dir)
	except:
		print # No op
	mlist = os.path.split(method["path"])
	call(["mv "+mlist[0]+"/times-* "+times_dir], shell=True)


