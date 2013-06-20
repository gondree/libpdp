#! /usr/bin/python
"""
A simple utility for managing remote S3 buckets for benchmarking libpdp.

"""
import os, sys
import argparse
import boto
from boto.s3.connection import OrdinaryCallingFormat

Id = "XXX"
Key = "YYY"
Host, Port = "192.168.99.173", "8080"

DEFAULT_BUCKETS = ["libpdp_data"]

###############################################################################
#
# Support functions
#
def sizeof_fmt(num):
    for x in ['b ','KB','MB','GB','TB', 'XB']:
        if num < 1024.0:
            return "%3.1f %s" % (num, x)
        num /= 1024.0
    return "%3.1f %s" % (num, x)

def list_all_buckets(s3, buckets=None):
    """List all the buckets"""
    for b in s3.get_all_buckets():
        if buckets and not b.name in buckets:
            continue
        total = 0
        num = 0
        print "BUCKET:", b.name
        for k in b.list():
            print "%s\t%s\t%010s\t%s" % ("-rwx---", k.last_modified,
                 sizeof_fmt(k.size), k.name)
            num += 1
            total += k.size
        print "="*80
        print "\tTOTAL: \t%010s \t%i Files" % (sizeof_fmt(total), num)

def delete_buckets(s3, buckets=None):
    """Delete buckets"""
    for b in buckets:
        try:
            print "Deleting %s" % b
            bo = s3.get_bucket(b)
            keys = bo.get_all_keys()
            for k in keys:
                bo.delete_key(k)
            s3.delete_bucket(b)
        except:
            print "The bucket %s couldn't be deleted." % b

def create_buckets(s3, buckets=None):
    """Create buckets"""
    for b in buckets:
        try:
            print "Creating %s" % b
            s3.create_bucket(b)
        except:
            print "Couldn't create bucket %s" % b

def get_file(s3, files=None):
    """Get a file from a bucket"""
    for f in files:
        bucket, key = f.split('/')
        bo = s3.lookup(bucket)
        key = bo.lookup(key)
        range = 'bytes=%s' % (args.range)
        data = key.get_contents_as_string(headers={'Range' : range })
        print "Retrieved", len(data), "bytes of", f
        print "["+data+"]"

###############################################################################
#
# Main
#
parser = argparse.ArgumentParser(description='Perform actions with S3.')
parser.add_argument("--mk", metavar="BUCKETS", nargs='*', default=False,
                    help="Create the named buckets")
parser.add_argument("--ls", metavar="BUCKETS", nargs='*', default=False,
                    help="List data about the named buckets")
parser.add_argument("--rm", metavar="BUCKETS", nargs='*', default=False,
                    help="Remove the named buckets")
parser.add_argument("--get", metavar="FILE", nargs='*', default=False,
                    help="Get the named file")
parser.add_argument("--range", metavar="RANGE", default="0-",
                    help="Get a range of bytes for the file")
args = parser.parse_args()

if __name__ == "__main__":
    if 'S3_ACCESS_KEY_ID' in os.environ:
        Id = os.environ['S3_ACCESS_KEY_ID']
    if 'S3_SECRET_ACCESS_KEY' in os.environ:
        Key = os.environ['S3_SECRET_ACCESS_KEY']
    if 'S3_HOSTNAME' in os.environ:
        Host, Port = os.environ['S3_HOSTNAME'].split(':')
    Port = int(Port)

    s3 = boto.connect_s3(Id, Key, host=Host, port=Port, is_secure=False, 
                         calling_format=OrdinaryCallingFormat())

    #
    # Bucket create
    #
    if not args.mk is False:
        if not args.mk:
            buckets = DEFAULT_BUCKETS
        else:
            buckets = args.mk
        create_buckets(s3, buckets)
    #
    # Bucket remove
    #
    if not args.rm is False:
        if not args.rm:
            buckets = DEFAULT_BUCKETS
        else:
            buckets = args.rm
        delete_buckets(s3, buckets)
    #
    # Bucket list
    #
    if not args.ls is False:
        list_all_buckets(s3, args.ls)

    #
    # Get file
    #
    if not args.get is False:
        get_file(s3, args.get)
