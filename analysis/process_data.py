#! /usr/bin/python

import csv  
import os
import glob
import cPickle as pickle
from collections import OrderedDict
import argparse
import time

def recast(data):
	# Ints are not floats are not strings
	x = False
	try:
		x = int(data)
	except ValueError:
		try:
			x = float(data)
		except ValueError:
			x = data # It's a string
	return x
  
def read_time_csv(file_name, data):
	""" Read the contents of a single times csv and add it to data """
	csv.register_dialect('pdpdata', delimiter='\t', quoting=csv.QUOTE_NONE)
	f = open(file_name, 'rb')
	reader = csv.reader(f, 'pdpdata')

	# We alternate header and data rows
	for i,row in enumerate(reader):
		if (i+1) % 2 == 0:
			for j in range(len(row)):
				x = recast(row[j])

				# Collection of goofy hacks 
				if h[j] == 'Metadata':
					metadata_list = x.split(':')
					for meta_item in metadata_list:
						keyname_list = meta_item.split(' ')
						if len(keyname_list) > 1:
							data_item = recast(keyname_list[-1])
							del keyname_list[-1]
							keyname = ' '.join(keyname_list)
							if keyname == 'Filename': 
								keyname = 'File size (kb)'
								data_item = data_item.split('_')[-1][:-2]
							data[-1][keyname] = [data_item]
									
					data[-1][h[j]].append(x)
				elif h[j] == 'Timestamp':
					data[-1][h[j]].append(int(time.mktime(time.strptime(x, '%a %b %d %H:%M:%S %Y'))))
				else:
					data[-1][h[j]].append(x)

		else:
			# New data point
			h = row
			v = [[] for k in range(len(h))]
			data.append(OrderedDict(zip(h,v)))

	f.close()



if not os.path.isdir('./data'):
	os.chdir('../')

# Container to hold all timing data
data = []
for dir_name in glob.glob('./data/all-times*/'):
	for file_name in glob.glob(dir_name+'times*'):
		read_time_csv(file_name, data)
	pickle.dump(data, open(dir_name+'exp_data.pickle','wb'))
	del data[:]

