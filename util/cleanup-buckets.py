#!/usr/bin/python
import boto
from boto.s3.connection import S3Connection
from boto.s3.connection import OrdinaryCallingFormat
import os

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

