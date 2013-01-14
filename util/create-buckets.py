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

# Make all the buckets
for b in buckets:
	try:
		print "Creating %s" % b
		conn.create_bucket(b)
	except:
		print "Couldn't create bucket %s" % b

