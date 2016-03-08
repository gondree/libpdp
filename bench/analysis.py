#! /usr/bin/python
import os, glob, csv, time, math, re
import cPickle as pickle
import numpy as np
from numpy import array, float64
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
from scipy.optimize import curve_fit
from scipy.interpolate import LinearNDInterpolator
from optparse import OptionParser
from collections import OrderedDict
from pprint import pprint
import inspect

###############################################################################
#
# Support Functions
#
SCHEME = None
OPT = None

# Give methods consistent symbology
point_colors = {'MAC-PDP':'ro', 'APDP':'bs', 
                'CPOR':'g^', 'SEPDP':'yp', 'PDP':'bs'}
avail_colors = {'MAC-PDP':'r', 'APDP':'b', 
                'CPOR':'g', 'SEPDP':'y', 'PDP': 'b'}
method_name = {'MAC-PDP':'MAC-PDP', 'APDP':'APDP', 
                'CPOR':'CPOR', 'SEPDP':'SEPDP', 'PDP': 'APDP'}

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


def processCSV(files=None):
    """ Open and process data in a set of CSV files.
    Each row is an experiment run. This is ugly, but works.
    """
    data = []
    csv.register_dialect('pdpdata', delimiter='\t', quoting=csv.QUOTE_NONE)
    for file in files:
        f = open(file, 'rb')
        reader = csv.reader(f, 'pdpdata')

        # alternate header and data rows in our files
        for i,row in enumerate(reader):
            if i % 2 == 0:
                # got a description of experiment data, but no data
                # reserve a dict to hold the data
                h = row  # save the header 'h'
                v = [[] for k in range(len(h))]
                data.append(OrderedDict(zip(h,v)))
            else:
                # got the data we will parse, matched with header 'h'
                # we will put into into the data[-1] dict we just reserved
                for j in range(len(row)):
                
                    # turn the data into its appropriate type
                    x = recast(row[j])
                    
                    if h[j] == 'Metadata':
                        # column j is metadata
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
                        data[-1]['Algo'] = x.split(':')[0]
                    elif h[j] == 'Timestamp':
                        # column j is a timestamp
                        t = time.strptime(x, '%a %b %d %H:%M:%S %Y')
                        data[-1][h[j]].append(int(time.mktime(t)))
                    else:
                        # column data is just a float, int, string
                        data[-1][h[j]].append(x)
        f.close()
    return data

def processOverhead(file=None):
    data = []
    try:
        f = open(file, 'r')
    except IOError:
        print 'cannot open', file
        return None
    for line in f:
        d = OrderedDict()
        line = line.strip()
        if not line:
            continue
        bs = re.search('(?<=--blocksize )\w+', line)
        algo = re.search('(?<=--algo )\w+', line)
        fs = re.search('(?<=testfile_rand_)\d+', line)
        if not bs or not algo or not fs:
            continue
        nextline = f.next().strip()
        overhead = re.search('(?<=INFO )\d+', nextline)
        if not overhead:
            print "Error: expecting a line with a file size in it!"
            continue
        d['Algo'] = algo.group(0)
        d['Block size'] = [bs.group(0)]
        d['File size (kb)'] = [fs.group(0)]
        d['Overhead'] = [float(overhead.group(0)) / 1024]

        for r in data:
            if (r['Algo'] == d['Algo'] and
                r['Block size'] == d['Block size'] and
                r['File size (kb)'] == d['File size (kb)']):
                if r['Overhead'] != d['Overhead']:
                    print "Error: We have a record and it disagrees:", d, r
                continue
        data.append(d)
    f.close()

    # fix the data to make it look like our other data
    for d in data:
        # MAC-PDP has a different name
        if d["Algo"] == "MAC":
            d["Algo"] = "MAC-PDP"
        # when we vary bs and fs is constant, we don't have fs attr
        if ('Block size' in d and 'File size (kb)' in d and
            d['Block size'][0] != '4096' and 
            d['File size (kb)'][0] == '32768'):
            del d['File size (kb)']
        # when we vary fs and bs is constant, we don't have bs attr
        if ('Block size' in d and 'File size (kb)' in d and
            d['Block size'][0] == '4096' and 
            d['File size (kb)'][0] != '32768'):
            del d['Block size']
    return data


###############################################################################
#
# Specific economic cost models
#

def apdp_overhead_cost(c0, c1, fs=2**25, bs=4096):
    return c0 + c1 * fs/bs

def cpor_overhead_cost(c0, c1, fs=2**25, bs=4096):
    return c0 + c1 * fs/bs

def macpdp_overhead_cost(c0, c1, fs=2**25, bs=4096):
    return c0 + c1 * fs/bs

def sepdp_overhead_cost(c0, c1, fs=2**25, bs=4096, magic=512, nt=12):
    return c0 + c1 * bs

def apdp_tag_cost(c0, c1, c2, c3, c4, c5, fs=2**25, bs=4096, rsa_len=2**7):
    """ default bs=16384; test default uses 4096 for ease of comparison """
    num_blocks = fs/bs

    """
    # We had to find these values in a strange way, constraining by block experiment data
    return 1.10047759e-03 + num_blocks * 1.21235534e-03 + num_blocks * bs * 1.34468972e-08

    for (x,y) in [(1024.0, 40.202888000000002), (1024.0, 40.339886900000003), (1024.0, 40.376019999999997), (2048.0, 20.368907), (2048.0, 20.3761151), (2048.0, 20.417718900000001), (4096.0, 10.387685100000001), (4096.0, 10.3915501), (4096.0, 10.4080672), (8192.0, 5.3969421000000004), (8192.0, 5.4190430999999997), (8192.0, 5.4261249999999999), (16384.0, 2.8974408999999999), (16384.0, 2.9158900000000001), (16384.0, 2.9193571), (32768.0, 1.6544019999999999), (32768.0, 1.6621509000000001), (32768.0, 1.6655731), (65536.0, 1.0317531), (65536.0, 1.0484530999999999), (65536.0, 1.0488337999999999), (131072.0, 0.71526409999999996), (131072.0, 0.72279309999999997), (131072.0, 0.73382499999999995), (262144.0, 0.58026), (262144.0, 0.5831809), (262144.0, 0.5862889), (524288.0, 0.50145320000000004), (524288.0, 0.50150110000000003), (524288.0, 0.50356719999999999), (1048576.0, 0.50504800000000005), (1048576.0, 0.53898000000000001), (1048576.0, 0.55619289999999999)]:
        yp = c0 + (2**25/x) * c1 + 2**25 * c2
        if math.fabs(y - yp) > 0.3:
            return 0
    """
    # return c0 + num_blocks * c1 + num_blocks * bs * c2
    return c0 + c1*fs/bs + c2*bs + c3*fs + c4*bs/fs

def cpor_tag_cost(c0, c1, c2, fs=2**25, bs=4096, lambd=80):
    ss = lambd/8 - 1
    num_blocks = fs/bs
    num_sectors = bs/ss
    return c0 + c1*fs + c2*num_blocks*num_sectors

def macpdp_tag_cost(c0, c1, fs=2**25, bs=4096):
    """ work is proportional to the number of bytes processed """
    bytes_processed = fs
    return c0 + c1 * bytes_processed

def sepdp_tag_cost(c0, c1, fs=2**25, bs=4096, magic=512, nt=12):
    """ nt = number of tokens = yr * 365 * 24 * 60 / min
        magic = number of challenges to generate for each token
        cost function switches at 2**11 kb 
    """
    num_blocks = math.ceil(fs/bs)
    num_chals = min(num_blocks, magic)
    bytes_processed = min(num_chals * bs, fs)
    return c0 + c1 * bytes_processed

def apdp_gets_cost(c0, c1, c2, c3, fs=2**25, bs=4096, rsa_len=2**7, magic=460):
    """ generic gets model 
        default bs=16384; test default uses 4096 for ease of comparison
    """
    num_blocks = math.ceil(fs/bs)
    if num_blocks >= magic:
        return c1 * magic
    else:
        return c0*num_blocks

def cpor_gets_cost(c0, c1, c2, c3, fs=2**25, bs=4096, lambd=80):
    """ generic gets model 
    """
    num_blocks = math.ceil(fs/bs)
    return c0 + min(c2, c1*num_blocks)

def macpdp_gets_cost(c0, c1, c2, c3, fs=2**25, bs=4096, magic=460):
    """ generic gets model 
    """
    num_blocks = math.ceil(fs/bs)
    if num_blocks >= magic:
        return c1*magic
    else:
        return c0*num_blocks

def sepdp_gets_cost(c0, c1, c2, c3, fs=2**25, bs=4096, magic=512, nt=12):
    """ generic gets model 
    """
    num_blocks = math.ceil(fs/bs)
    return c0 + min(c2, c1*num_blocks)

def apdp_chal_cost(c0, c1, c2, fs=2**25, bs=4096, magic=460):
    """ generic challenge model 
        default bs=16384; test default uses 4096 for ease of comparison
    """
    return c0*magic

def cpor_chal_cost(c0, c1, c2, fs=2**25, bs=4096, magic=80):
    """ generic challenge model 
    """
    num_blocks = math.ceil(fs/bs)
    if num_blocks >= magic:
        return c0 + c1*magic
    else:
        return c0 + c2*num_blocks

def mac_chal_cost(c0, c1, c2, fs=2**25, bs=4096, magic=460):
    """ generic challenge model 
    """
    num_blocks = fs/bs
    if num_blocks < magic:
        return c0
    else:
        return c1   

def sepdp_chal_cost(c0, c1, c2, fs=2**25, bs=4096, magic=512):
    """ generic challenge model 
    """
    return c0*magic

def apdp_proof_cost(c0, c1, c2, c3, c4, c5, fs=2**25, bs=4096, magic=460):
    """ generic proof model 
        default bs=16384; test default uses 4096 for ease of comparison
    """
    num_blocks = fs/bs

# This works for block and file_size v. time separately, but not for both
    if num_blocks < magic:
	## print("Debug c1..c5: ", c1, c2, c3, c4, c5)
        return c2 + c3 * fs/bs + c4*bs + c5*fs
    else:
	## print("Debug c1..c5: ", c1, c2, c3, c4, c5)
        return c0 + c1 * magic * bs  

def cpor_proof_cost(c0, c1, c2, c3, c4, c5, fs=2**25, bs=4096, lambd=80):
    """ generic proof model 
    """
    ss = lambd/8-1
    magic = lambd
    num_sectors = bs/ss
    num_blocks = fs/bs
    num_chals = min(num_blocks, magic)

    # ????
    #if num_blocks < magic:
    #    return c2 + c3 * fs**2
    #else:
    #    return c0 + num_chals * bs * c1

    if num_blocks < magic:
        return c0 + c1 * num_blocks * bs
    else:
        return c0 + c1 * magic * bs


def mac_proof_cost(c0, c1, c2, c3, c4, c5,c6,c7, fs=2**25, bs=4096, magic=460):
    """ generic proof model 
    """
    num_blocks = fs/bs

    if num_blocks < magic:
        return c4 + c5 * fs/bs + c6*bs + c7*fs
    else:
        # return c0 + c1 * magic * bs   #### this was close but not precise; did not reflect slight incr in fs time
	return c0 + c1 * fs/bs + c2*fs + c3 *bs

def sepdp_proof_cost(c0, c1, c2, fs=2**25, bs=4096, magic=512):
    """ generic proof model 
    """
    num_blocks = fs/bs
    if num_blocks < magic:
        return c0 + c1 * num_blocks * bs
    else:
        return c0 + c1 * magic * bs

def apdp_verify_cost(c0, c1, c2, fs=2**25, bs=4096, magic=460):
    """ generic verify model 
        default bs=16384; test default uses 4096 for ease of comparison
    """
    num_blocks = fs/bs
    if (num_blocks >= magic):
        return c2
    else:
        return c0 + c1*num_blocks   

def cpor_verify_cost(c0, c1, c2, c3, c4, c5, fs=2**25, bs=4096, lambd=80):
    """ generic verify model 
    """
    ss = lambd/8-1
    magic = lambd
    num_sectors = bs/ss
#    return c0 + c1 * magic * num_sectors	#This model didn't account for slight dip for fs<~2^8
    num_blocks = fs/bs
    if (num_blocks < magic):
	return c2 + c3 * fs/bs + c4*fs + c5*bs
    else:
    	return c0 + c1 * magic * bs


def mac_verify_cost(c0, c1, c2, fs=2**25, bs=4096, magic=460):
    """ generic verify model 
    """
    num_blocks = fs/bs
    blocks_processed = min(num_blocks, magic)
    return c0 + c1 * blocks_processed * bs

def sepdp_verify_cost(c0, c1, c2, fs=2**25, bs=4096, magic=512):
    """ generic verify model 
    """
    return c0


###############################################################################
#
# Generic economic cost models, for curve fitting
#

def select_fun(case=None, Xattrib=None, Yattrib=None):
    """ Set up the cost function and any guesses to use for fitting curves
    """
    global SCHEME
    SCHEME = case # a global hack for fit_func global params
    guess = None
    f = None
    if (Yattrib == "Create tag"):
        if (Xattrib == "Block size"):
            f = create_tag_block_cost
        elif (Xattrib == "File size (kb)"):
            f = create_tag_cost
        if case == "APDP":
            guess = (-0.00013193282611523083, 0.0012177431942119131, -3.6199888348773166e-09, 1.3364404699695748e-08, 0.0003181431711876885, 1)
        elif case == "CPOR":
            guess = (5.2e-04, 4e-08, 7.01e-10, 1, 1, 1)
        elif case == "MAC-PDP":
            guess = (3.589e-05, 2.055e-09, 1, 1, 1, 1)
        elif case == "SEPDP":
            guess = (5.5e-05, 1.88363090e-9, 1, 1, 1, 1)
    elif (Yattrib == "Create challenge"):
        if (Xattrib == "Block size"):
            f = create_chal_block_cost
        elif (Xattrib == "File size (kb)"):
            f = create_chal_cost
        if case == "APDP":
            guess = (1.59025692e-06, 1, 1, 1, 1, 1)
        elif case == "CPOR":
            guess = (8.4e-06, 2.0e-06, 1.66621754e-06, 1, 1, 1)
        elif case == "MAC-PDP":
            guess = (7.803333333333340E-06, 1.809903225806450E-04, 1, 1, 1, 1)
        elif case == "SEPDP":
            guess = (1.44e-08, 1, 1, 1, 1, 1)
        else:
            guess = (1, 1, 1, 1, 1, 1)
    elif (Yattrib == "Create proof"):
        if (Xattrib == "Block size"):
            f = create_proof_block_cost
        elif (Xattrib == "File size (kb)"):
            f = create_proof_cost
        if case == "APDP":
            guess = (0.091773342906608, 1.1935712820358526e-08, -0.0010867091458787968, 0.00015963367185163464, 4.634582376776001e-06, 1.9659722773520156e-09, 1, 1)
        elif case == "CPOR":
            guess = (6.9e-05, 3.95314210e-8, 1, 1, 1, 1,1,1)
        elif case == "MAC-PDP":
            guess = (.0005768245706505574, 4.887303900216258e-09, -8.459090033156705e-13, 1.6544250733286843e-07, 2.7019428203652935e-05, 6.604912596745636e-07, 5.988314545834848e-10, 3.536887922306163e-10)
        elif case == "SEPDP":
            guess = (4.4e-05, 1.72794101e-09, 1, 1, 1, 1, 1,1)
    elif (Yattrib == "Verify file"):
        if (Xattrib == "Block size"):
            f = verify_proof_block_cost
        elif (Xattrib == "File size (kb)"):
            f = verify_proof_cost
        if case == "APDP":
            guess = (8.76738439e-04, 1.13043758e-04, 5.43752333e-02, 1, 1, 1)
        elif case == "CPOR":
            guess = (1.83097080e-04, 8.37030310e-10, 2.1352354485101163e-05, 2.197988555658482e-06, -1.757917570556099e-11, 6.727327149794464e-08)
        elif case == "MAC-PDP":
            guess = (1.34748167e-05, 1.84981378e-09, 1, 1, 1, 1)
        elif case == "SEPDP":
            guess = (1.40883333e-05, 1, 1, 1, 1, 1)
    elif (Yattrib == "GET"):
        if (Xattrib == "Block size"):
            f = num_gets_block_cost
        elif (Xattrib == "File size (kb)"):
            f = num_gets_cost
        if case == "APDP":
            guess = (1.95459019, 2, 1, 1)
        elif case == "CPOR":
            guess = (0.19991213, 1.97188049, 159.80008787, 1)
        elif case == "MAC-PDP":
            guess = (2, 2, 1, 1)
        elif case == "SEPDP":
            guess = (1.23212943, 0.97593497, 459.76787057, 1)
    elif (Yattrib == "Overhead"):
        if (Xattrib == "Block size"):
            f = overhead_block_cost
        elif (Xattrib == "File size (kb)"):
            f = overhead_cost
        if case == "APDP":
            guess = (0.0296641, 0.19454811, 1, 1, 1, 1)
        elif case == "CPOR":
            guess = (0.00261741, 0.01716601, 1, 1, 1, 1)
        elif case == "MAC-PDP":
            guess = (0.00290825, 0.01907334, 1, 1, 1, 1)
        elif case == "SEPDP":
            guess = (9.37500000e-02, 9.76562500e-04, 1, 1, 1, 1)
    return (f, guess)

def verify_proof_cost(x, c0, c1, c2, c3, c4, c5):
    """ A cost function for file size vs. verifying time.
    
        Ex: ./analysis.py --exp_path ../data/all-times-file-size/ 
        --Xattrib 'File size (kb)' --Yattrib 'Verify file' 
        --Xlabel 'File size (kb)' --fit_curve
    """
    case = SCHEME
    kb = 2**10   # bytes in kb
    if case == "APDP":
        ans = [apdp_verify_cost(c0, c1, c2, fs=f*kb) for f in x]
    elif case == "CPOR":
        ans = [cpor_verify_cost(c0, c1, c2, c3, c4, c5, fs=f*kb) for f in x]
    elif case == "MAC-PDP":
        ans = [mac_verify_cost(c0, c1, c2, fs=f*kb) for f in x]
    elif case == "SEPDP":
        ans = [sepdp_verify_cost(c0, c1, c2, fs=f*kb) for f in x]
    else:
        ans = [0 for i in x]
    return array(ans)

def verify_proof_block_cost(x, c0, c1, c2, c3, c4, c5):
    """ A cost function for block size vs. verify time.
    """
    case = SCHEME    
    if case == "APDP":
        ans = [apdp_verify_cost(c0, c1, c2, bs=b) for b in x]
    elif case == "CPOR":
        ans = [cpor_verify_cost(c0, c1, c2, c3, c4, c5, bs=b) for b in x]
    elif case == "MAC-PDP":
        ans = [mac_verify_cost(c0, c1, c2, bs=b) for b in x]
    elif case == "SEPDP":
        ans = [sepdp_verify_cost(c0, c1, c2, bs=b) for b in x]
    else:
        ans = [0 for i in x]
    return array(ans)

def create_proof_cost(x, c0, c1, c2, c3, c4, c5, c6, c7):
    """ A cost function for file size vs. proof generation time.
    
        Ex: ./analysis.py --exp_path ../data/all-times-file-size/ 
        --Xattrib 'File size (kb)' --Yattrib 'Create proof' 
        --Xlabel 'File size (kb)' --fit_curve
    """
    case = SCHEME
    kb = 2**10   # bytes in kb
    if case == "APDP":
        ans = [apdp_proof_cost(c0, c1, c2, c3, c4, c5, fs=f*kb) for f in x]
    elif case == "CPOR":
        ans = [cpor_proof_cost(c0, c1, c2, c3, c4, c5, fs=f*kb) for f in x]
    elif case == "MAC-PDP":
        ans = [mac_proof_cost(c0, c1, c2, c3, c4, c5,c6,c7, fs=f*kb) for f in x]
    elif case == "SEPDP":
        ans = [sepdp_proof_cost(c0, c1, c2, fs=f*kb) for f in x]
    else:
        ans = [0 for i in x]
    return array(ans)

def create_proof_block_cost(x, c0, c1, c2, c3, c4, c5, c6, c7):
    """ A cost function for block size vs. proof generation time.
    """
    case = SCHEME    
    if case == "APDP":
        ans = [apdp_proof_cost(c0, c1, c2, c3, c4, c5, bs=b) for b in x]
    elif case == "CPOR":
        ans = [cpor_proof_cost(c0, c1, c2, c3, c4, c5, bs=b) for b in x]
    elif case == "MAC-PDP":
        ans = [mac_proof_cost(c0, c1, c2, c3, c4, c5,c6,c7, bs=b) for b in x]
    elif case == "SEPDP":
        ans = [sepdp_proof_cost(c0, c1, c2, bs=b) for b in x]
    else:
        ans = [0 for i in x]
    return array(ans)

def create_chal_cost(x, c0, c1, c2, c3, c4, c5):
    """ A cost function for file size vs. challenging time.
    """
    case = SCHEME
    kb = 2**10   # kb, in bytes
    if case == "APDP":
        ans = [apdp_chal_cost(c0, c1, c2, fs=f*kb) for f in x]
    elif case == "CPOR":
        ans = [cpor_chal_cost(c0, c1, c2, fs=f*kb) for f in x]
    elif case == "MAC-PDP":
        ans = [mac_chal_cost(c0, c1, c2, fs=f*kb) for f in x]
    elif case == "SEPDP":
        ans = [sepdp_chal_cost(c0, c1, c2, fs=f*kb) for f in x]
    else:
        ans = [0 for i in x]
    return array(ans)

def create_chal_block_cost(x, c0, c1, c2, c3, c4, c5):
    """ A cost function for file size vs. challenging time.
    """
    case = SCHEME    
    if case == "APDP":
        ans = [apdp_chal_cost(c0, c1, c2, bs=b) for b in x]
    elif case == "CPOR":
        ans = [cpor_chal_cost(c0, c1, c2, bs=b) for b in x]
    elif case == "MAC-PDP":
        ans = [mac_chal_cost(c0, c1, c2, bs=b) for b in x]
    elif case == "SEPDP":
        ans = [sepdp_chal_cost(c0, c1, c2, bs=b) for b in x]
    else:
        ans = [0 for i in x]
    return array(ans)

def num_gets_cost(x, c0, c1, c2, c3):
    """ A cost function for file size vs. no. of GETs.
    
        Ex: ./analysis.py --exp_path ../data/all-times-file-size-ec2/ 
        --Xattrib 'File size (kb)' --Yattrib 'GET' 
        --Xlabel 'File size (kb)' --fit_curve
    """
    case = SCHEME
    kb = 2**10   # bytes in kb
    if case == "APDP":
        ans = [apdp_gets_cost(c0, c1, c2, c3, fs=f*kb) for f in x]
    elif case == "CPOR":
        ans = [cpor_gets_cost(c0, c1, c2, c3, fs=f*kb) for f in x]
    elif case == "MAC-PDP":
        ans = [macpdp_gets_cost(c0, c1, c2, c3, fs=f*kb) for f in x]
    elif case == "SEPDP":
        ans = [sepdp_gets_cost(c0, c1, c2, c3, fs=f*kb) for f in x]
    else:
        ans = [0 for i in x]
    return array(ans)

def num_gets_block_cost(x, c0, c1, c2, c3):
    """ A cost function for file size vs. tagging time.
    """
    case = SCHEME    
    if case == "APDP":
        ans = [apdp_gets_cost(c0, c1, c2, c3, bs=b) for b in x]
    elif case == "CPOR":
        ans = [cpor_gets_cost(c0, c1, c2, c3, bs=b) for b in x]
    elif case == "MAC-PDP":
        ans = [macpdp_gets_cost(c0, c1, c2, c3, bs=b) for b in x]
    elif case == "SEPDP":
        ans = [sepdp_gets_cost(c0, c1, c2, c3, bs=b) for b in x]
    else:
        ans = [0 for i in x]
    return array(ans)

def create_tag_cost(x, c0, c1, c2, c3, c4, c5):
    """ A cost function for file size vs. tagging time.
    
        Ex: ./analysis.py --exp_path ../data/all-times-file-size/ 
        --Xattrib 'File size (kb)' --Yattrib 'Create tag' 
        --Xlabel 'File size (kb)' --fit_curve
    """
    case = SCHEME
    kb = 2**10   # kb, in bytes
    if case == "APDP":
        ans = [apdp_tag_cost(c0, c1, c2, c3, c4, c5, fs=f*kb) for f in x]
    elif case == "CPOR":
        ans = [cpor_tag_cost(c0, c1, c2, fs=f*kb) for f in x]
    elif case == "MAC-PDP":
        ans = [macpdp_tag_cost(c0, c1, fs=f*kb) for f in x]
    elif case == "SEPDP":
        ans = [sepdp_tag_cost(c0, c1, fs=f*kb) for f in x]
    else:
        ans = [0 for i in x]
    return array(ans)

def create_tag_block_cost(x, c0, c1, c2, c3, c4, c5):
    """ A cost function for file size vs. tagging time.
    
        Ex: ./analysis.py --exp_path ../data/all-times-block-size/ 
        --Xattrib 'Block size' --Yattrib 'Create tag' 
        --Xlabel 'Block size (bytes)' --fit_curve
    """
    case = SCHEME    
    if case == "APDP":
        ans = [apdp_tag_cost(c0, c1, c2, c3, c4, c5, bs=b) for b in x]
    elif case == "CPOR":
        ans = [cpor_tag_cost(c0, c1, c2, bs=b) for b in x]
    elif case == "MAC-PDP":
        ans = [macpdp_tag_cost(c0, c1, bs=b) for b in x]
    elif case == "SEPDP":
        ans = [sepdp_tag_cost(c0, c1, bs=b) for b in x]
    else:
        ans = [0 for i in x]
    return array(ans)

def overhead_cost(x, c0, c1, c2, c3, c4, c5):
    """ A cost function for file size vs. overhead.
    """
    case = SCHEME
    kb = 2**10   # kb, in bytes
    if case == "APDP":
        ans = [apdp_overhead_cost(c0, c1, fs=f*kb) for f in x]
    elif case == "CPOR":
        ans = [cpor_overhead_cost(c0, c1, fs=f*kb) for f in x]
    elif case == "MAC-PDP":
        ans = [macpdp_overhead_cost(c0, c1, fs=f*kb) for f in x]
    elif case == "SEPDP":
        ans = [sepdp_overhead_cost(c0, c1, fs=f*kb) for f in x]
    else:
        ans = [0 for i in x]
    return array(ans)

def overhead_block_cost(x, c0, c1, c2, c3, c4, c5):
    """ A cost function for file size vs. overhead.
    """
    case = SCHEME    
    if case == "APDP":
        ans = [apdp_overhead_cost(c0, c1, bs=b) for b in x]
    elif case == "CPOR":
        ans = [cpor_overhead_cost(c0, c1, bs=b) for b in x]
    elif case == "MAC-PDP":
        ans = [macpdp_overhead_cost(c0, c1, bs=b) for b in x]
    elif case == "SEPDP":
        ans = [sepdp_overhead_cost(c0, c1, bs=b) for b in x]
    else:
        ans = [0 for i in x]
    return array(ans)

###############################################################################
#
# Cost, via cloud economic models,
#

# In dollars, from https://aws.amazon.com/s3/pricing/
AWS = {"per-put" : 0.011/1000,
       "per-get" : 0.011/10000,
       "per-hr" : 0.17,
       "gb-store" : [{"start":0, "end":1024, "cost":0.093},
                     {"start":1024, "end":49*1024, "cost":0.083},
                     {"start":49*1024, "end":450*1024, "cost":0.073},
                     {"start":450*1024, "end":500*1024, "cost":0.063},
                     {"start":500*1024, "end":4000*1024, "cost":0.053},
                     {"start":4000*1024, "end":float("inf"), "cost":0.037}],
       "gb-out" : [{"start":0, "end":1, "cost":0.00},
                   {"start":1, "end":10*1024, "cost":0.150},
                   {"start":10*1024, "end":40*1024, "cost":0.110},
                   {"start":40*1024, "end":100*1024, "cost":0.090},
                   {"start":100*1024, "end":150*1024, "cost":0.080}],
       "gb-in"  : [{"start":0, "end":float("inf"), "cost":0.0}]
}


def preprocess_cost_per_fs(xdata, alg="MAC-PDP", model=AWS):
    """ xdata = list of sizes (kb) 
    """
    Xaxis="File size (kb)"
    tfunc, topt = select_fun(case=alg, Xattrib=Xaxis, Yattrib="Create tag")
    cfunc, copt = select_fun(case=alg, Xattrib=Xaxis, Yattrib="Create challenge")
    pfunc, popt = select_fun(case=alg, Xattrib=Xaxis, Yattrib="Create proof")
    vfunc, vopt = select_fun(case=alg, Xattrib=Xaxis, Yattrib="Verify file")
    gfunc, gopt = select_fun(case=alg, Xattrib=Xaxis, Yattrib="GET")
    ofunc, oopt = select_fun(case=alg, Xattrib=Xaxis, Yattrib="Overhead")

    for o in [topt, copt, popt, vopt, gopt, oopt]:
        o = [x for x in o]

    tdata = tfunc(xdata, *topt)
    cdata = cfunc(xdata, *copt)
    pdata = pfunc(xdata, *popt)
    vdata = vfunc(xdata, *vopt)
    gdata = gfunc(xdata, *gopt)
    odata = ofunc(xdata, *oopt)

    cost = []
    for i in range(len(xdata)):
        total_cost = 0

        # cost of uploading data
        # ignore this cost: we will always have this upload cost

        # cost to put the tag
        # we ignore the tag put cost (can be merged w/ data put cost)

        # cost to upload the tag
        remaining = odata[i]/1024   # in GB
        upload_cost = 0
        for tier in model['gb-in']:
            if remaining >= tier['start']:
                moved = min(remaining, tier['end'])
                remaining = remaining - moved
                upload_cost = upload_cost + moved * tier['cost']
        total_cost = total_cost + upload_cost
        
        # cost per-hr of tag computation
        tag_cost = tdata[i]/(60*60) * model['per-hr']
        total_cost = total_cost + tag_cost

        cost.append(total_cost)
    return cost


def storage_cost_per_fs(xdata, alg="MAC-PDP", model=AWS):
    """ xdata = list of sizes (kb) 
    """
    Xaxis="File size (kb)"
    tfunc, topt = select_fun(case=alg, Xattrib=Xaxis, Yattrib="Create tag")
    cfunc, copt = select_fun(case=alg, Xattrib=Xaxis, Yattrib="Create challenge")
    pfunc, popt = select_fun(case=alg, Xattrib=Xaxis, Yattrib="Create proof")
    vfunc, vopt = select_fun(case=alg, Xattrib=Xaxis, Yattrib="Verify file")
    gfunc, gopt = select_fun(case=alg, Xattrib=Xaxis, Yattrib="GET")
    ofunc, oopt = select_fun(case=alg, Xattrib=Xaxis, Yattrib="Overhead")

    for o in [topt, copt, popt, vopt, gopt, oopt]:
        o = [x for x in o]

    tdata = tfunc(xdata, *topt)
    cdata = cfunc(xdata, *copt)
    pdata = pfunc(xdata, *popt)
    vdata = vfunc(xdata, *vopt)
    gdata = gfunc(xdata, *gopt)
    odata = ofunc(xdata, *oopt)

    cost = []
    for i in range(len(xdata)):
        total_cost = 0

        # cost to store the tag
        remaining = odata[i]/1024   # in GB
        upload_cost = 0
        for tier in model['gb-store']:
            if remaining >= tier['start']:
                moved = min(remaining, tier['end'])
                remaining = remaining - moved
                upload_cost = upload_cost + moved * tier['cost']
        total_cost = total_cost + upload_cost

        cost.append(total_cost)
    return cost


def audit_cost_per_fs(xdata, alg="MAC-PDP", model=AWS):
    """ xdata = list of sizes (kb) 
    """
    Xaxis="File size (kb)"
    tfunc, topt = select_fun(case=alg, Xattrib=Xaxis, Yattrib="Create tag")
    cfunc, copt = select_fun(case=alg, Xattrib=Xaxis, Yattrib="Create challenge")
    pfunc, popt = select_fun(case=alg, Xattrib=Xaxis, Yattrib="Create proof")
    vfunc, vopt = select_fun(case=alg, Xattrib=Xaxis, Yattrib="Verify file")
    gfunc, gopt = select_fun(case=alg, Xattrib=Xaxis, Yattrib="GET")
    ofunc, oopt = select_fun(case=alg, Xattrib=Xaxis, Yattrib="Overhead")

    for o in [topt, copt, popt, vopt, gopt, oopt]:
        o = [x for x in o]

    tdata = tfunc(xdata, *topt)
    cdata = cfunc(xdata, *copt)
    pdata = pfunc(xdata, *popt)
    vdata = vfunc(xdata, *vopt)
    gdata = gfunc(xdata, *gopt)
    odata = ofunc(xdata, *oopt)

    cost = []
    for i in range(len(xdata)):
        total_cost = 0

        get_cost = gdata[i] * model['per-get']
        total_cost = total_cost + get_cost

        # cost to send challenge
        # cost to send proof
        # we ignore these costs: inter-AWS xfer is free

        # cost for challenging (hr)
        chal_cost = cdata[i]/(60*60) * model['per-hr']
        total_cost = total_cost + chal_cost

        # cost for proving (hr)
        prove_cost = pdata[i]/(60*60) * model['per-hr']
        total_cost = total_cost + prove_cost

        # cost for verifying (hr)
        ver_cost = vdata[i]/(60*60) * model['per-hr']
        total_cost = total_cost + ver_cost

        cost.append(total_cost)
    return cost


def cost_to_tag():
    plotname = inspect.stack()[0][3]

    shown_methods = ['MAC-PDP', 'APDP', 'CPOR']
    fig = plt.figure()
    p = fig.add_subplot(1,1,1)
    
    for M in shown_methods:
        xdata = [float64((2**x)) for x in range(10, 53)]
        ydata = preprocess_cost_per_fs(xdata, alg=M)
        p.hold(True)
        p.plot(xdata, ydata, color=avail_colors[M])
        p.hold(False)

    # set scaling
    Xscale, Yscale = 'log', 'log'
    if Xscale != 'linear':
        p.set_xscale('log', basex=2)
    if Yscale != 'linear':
        p.set_yscale('log', basey=2)

    # axis format
    p.yaxis.set_major_formatter(ticker.FuncFormatter(sizeof_dollars))
    p.xaxis.set_major_formatter(ticker.FuncFormatter(sizeof_fmt))
    plt.setp(plt.xticks()[1], size=8, rotation=15)
    plt.setp(plt.yticks()[1], size=8)

    # axis labels
    p.set_xlabel("File size")
    p.set_ylabel("Cost ($)")
    # legend
    method_labels = [method_name[M] for M in shown_methods]
    p.legend(method_labels, loc='upper center', numpoints=1,
             bbox_to_anchor=(0.5, 1.1), fancybox=True, shadow=True, ncol=4)

    # save and close it
    plt.savefig(OPT.output + "/" + plotname + ".png", bbox_inches=0)
    plt.close()


def cost_to_store_tag():
    plotname = inspect.stack()[0][3]

    shown_methods = ['MAC-PDP', 'APDP', 'CPOR']
    fig = plt.figure()
    p = fig.add_subplot(1,1,1)
    
    for M in shown_methods:
        xdata = [float64((2**x)) for x in range(10, 53)]
        ydata = storage_cost_per_fs(xdata, alg=M)
        p.hold(True)
        p.plot(xdata, ydata, color=avail_colors[M])
        p.hold(False)

    # set scaling
    Xscale, Yscale = 'log', 'log'
    if Xscale != 'linear':
        p.set_xscale('log', basex=2)
    if Yscale != 'linear':
        p.set_yscale('log', basey=2)

    # axis format
    p.yaxis.set_major_formatter(ticker.FuncFormatter(sizeof_dollars))
    p.xaxis.set_major_formatter(ticker.FuncFormatter(sizeof_fmt))
    plt.setp(plt.xticks()[1], size=8, rotation=15)
    plt.setp(plt.yticks()[1], size=8)

    # axis labels
    p.set_xlabel("File size")
    p.set_ylabel("Cost ($)")
    # legend
    method_labels = [method_name[M] for M in shown_methods]
    p.legend(method_labels, loc='upper center', numpoints=1,
             bbox_to_anchor=(0.5, 1.1), fancybox=True, shadow=True, ncol=4)

    # save and close it
    plt.savefig(OPT.output + "/" + plotname + ".png", bbox_inches=0)
    plt.close()


def cost_to_audit():
    plotname = inspect.stack()[0][3]

    shown_methods = ['MAC-PDP', 'APDP', 'CPOR']
    fig = plt.figure()
    p = fig.add_subplot(1,1,1)
    
    for M in shown_methods:
        xdata = [float64((2**x)) for x in range(0, 20)]
        ydata = audit_cost_per_fs(xdata, alg=M)
        p.hold(True)
        p.plot(xdata, ydata, color=avail_colors[M])
        p.hold(False)

    # set scaling
    Xscale, Yscale = 'log', 'log'
    if Xscale != 'linear':
        p.set_xscale('log', basex=2)
    if Yscale != 'linear':
        p.set_yscale('log', basey=2)

    # axis format
    p.yaxis.set_major_formatter(ticker.FuncFormatter(sizeof_dollars))
    p.xaxis.set_major_formatter(ticker.FuncFormatter(sizeof_fmt))
    plt.setp(plt.xticks()[1], size=8, rotation=15)
    plt.setp(plt.yticks()[1], size=8)

    # axis labels
    p.set_xlabel("File size")
    p.set_ylabel("Cost ($)")
    # legend
    method_labels = [method_name[M] for M in shown_methods]
    p.legend(method_labels, loc='upper center', numpoints=1,
             bbox_to_anchor=(0.5, 1.1), fancybox=True, shadow=True, ncol=4)

    # save and close it
    plt.savefig(OPT.output + "/" + plotname + ".png", bbox_inches=0)
    plt.close()


def sizeof_dollars(x, pos):
    x = x/100 # turn cents into dollars
    if x > 1e5:
        return "$%3.1fM" % (x * 1e-6)
    if x > 0.01:
        return "$%6.2f" % (x)
    if x > 0.00001:
        return "%1.3f%s" % (x*100, u"\u00A2")
    return "%1.2e%s" % (x*100, u"\u00A2")

def sizeof_fmt(num, pos):
    for x in ['b','KB','MB','GB','TB']:
        if num < 1024.0:
            return "%3.1f%s" % (num, x)
        num /= 1024.0
    return "%3.1f%s" % (num, 'PB')


###############################################################################
#
# A generic plotting function
#

def plotData(data, Xattrib=False, Yattrib=False, Xscale='log', Yscale='log',
             Xlabel=None, Ylabel=None, exclude=[], fit_curve=False,
             average=False):
    #
    # For debugging: target certain graphs
    #
    filter = None
    #filter = ['APDP']
    #filter = ['CPOR']
    #filter = ['APDP','SEPDP','CPOR']

    #
    # Get available attributes
    #
    Methods = []
    Keys = []
    for point in data:
        mn = point['Algo']
        if mn not in Methods:
            Methods.append(mn)
            Keys.append(point.keys())
            continue
        else:
            i = Methods.index(mn)
            for k in point.keys():
                if not k in Keys[i]:
                    Keys[i].append(k)            
    Methods.sort()

    #
    # Ensure methods are correct
    #
    All = OrderedDict()
    shown_methods = []
    for i,M in enumerate(Methods):
        if (M not in exclude and Xattrib in Keys[i] and Yattrib in Keys[i]):
            shown_methods.append(M)
            All[M+':X'] = []
            All[M+':Y'] = []

    idx = 0
    for point in data:
        M = point['Algo']
        if M in shown_methods:
            # Not every method has the same attributes
            if Xattrib not in point or Yattrib not in point:
                continue
            All[M+':X'].append(point[Xattrib])
            All[M+':Y'].append(np.mean(point[Yattrib]))

    if average:
        for M in shown_methods:
            avgY = OrderedDict()
            for x,y in zip(All[M+':X'], All[M+':Y']):
                x = x[0]
                if x not in avgY.keys():
                    avgY[x] = [y]
                else:
                    avgY[x].append(y)
            for i in avgY.keys():
                avgY[i] = np.mean(avgY[i])
            All[M+':X'] = avgY.keys()
            All[M+':Y'] = avgY.values()

    #
    # Begin plotting
    #
    fig = plt.figure()
    p = fig.add_subplot(1,1,1)
    
    # set scaling
    if Xscale != 'linear':
        p.set_xscale('log', basex=2)
    if Yscale != 'linear':
        p.set_yscale('log', basey=2)

    # Plot 'em
    p.hold(True)
    for M in shown_methods:
        if not filter is None and not method_name[M] in filter:
            continue
        # Plot it:
        #
        p.plot(All[M+':X'], All[M+':Y'], point_colors[M])
    p.hold(False)

    #
    # Fit curves
    #
    if fit_curve:
        print "Params for curve fitting:"
        for M in shown_methods:
            if not filter is None and not method_name[M] in filter:
                continue
            # Fit and plot the fit:
            #

            # select the right function to fit
            fit_func, guess = select_fun(case=method_name[M], 
                                         Xattrib=Xattrib, Yattrib=Yattrib)

            # grab the data
            xdata = [float64(x[0]) for x in All[M+':X']]
            ydata = [float64(y) for y in All[M+':Y']]
            
            # sort it
            data = sorted(zip(xdata, ydata))
            xdata, ydata = zip(*data)
            # get fit params
            opt, cov = curve_fit(fit_func, xdata, ydata, p0=guess)
            

            # to force 'guess' params to be graphed
            if OPT.guess and not guess is None:
                opt = [x for x in guess]  

            # plot fitted
            ydata = fit_func(xdata, *opt)

            color = avail_colors[M]
            p.hold(True)
            p.plot(xdata, ydata, color=color)
            p.hold(False)

            print fit_func.__name__+"() :"
            print "\t", M, "guess = ", guess
            print "\t", M, "opt   = ", opt

    # Put legend above plot
    method_labels = [method_name[M] for M in shown_methods]
    p.legend(method_labels, loc='upper center', numpoints=1,
             bbox_to_anchor=(0.5, 1.1), fancybox=True, shadow=True, ncol=4)
    
    # Apply labels
    if Xlabel != None:
        p.set_xlabel(Xlabel)
    else:
        p.set_xlabel(Xattrib)
    
    if Ylabel != None:
        p.set_ylabel(Ylabel)
    else:
        p.set_ylabel(Yattrib)

    if OPT.output is not None:
        if Xattrib == 'Block size':
            plotname = "blocksize_vs_"
        elif Xattrib == 'File size (kb)':
            plotname = "filesize_vs_"
        else:
            plotname = Xattrib + "_vs_"
        if Yattrib == 'Create tag':
            plotname = plotname + "tag_time"
        elif Yattrib == 'GET':
            plotname = plotname + "gets"
        elif Yattrib == 'PUT':
            plotname = plotname + "puts"
        elif Yattrib == 'Create challenge':
            plotname = plotname + "chal_time"
        elif Yattrib == 'Create proof':
            plotname = plotname + "proof_time"
        elif Yattrib == 'Verify file':
            plotname = plotname + "verify_time"
        elif Yattrib == 'Overhead':
            plotname = plotname + "overhead"
        else:
            plotname = plotname + Yattrib
        plt.savefig(OPT.output + "/" + plotname + ".png", bbox_inches=0)
    plt.close()


###############################################################################
#
# Main
#
if __name__=="__main__":
    SCRIPTPATH = os.path.dirname(os.path.abspath(__file__))
    data = []

    parser = OptionParser(description='Perform PDP data analysis.')

    # file options
    parser.add_option("--csv-data", metavar="PATH", type=str, 
        dest='csv_path', default=None,
        help="path to directory holding CSV data.")
    parser.add_option("--overhead-data", metavar="PATH", type=str, 
        dest='overhead_path', default=None,
        help="path to directory holding overhead data.")
    parser.add_option("--output", metavar="PATH", type=str,
        dest='output', default=SCRIPTPATH+"/output",
        help="path to directory to hold all output data.")

    # basic graph options
    parser.add_option("--Xattrib", metavar="ATTRIB", type=str, 
        dest='Xattrib', default=None,
        help="X axis attribute.")
    parser.add_option("--Yattrib", metavar="ATTRIB", type=str, 
        dest='Yattrib', default=None,
        help='Y axis attribute.')
    parser.add_option("--Xlabel", metavar="LABEL", type=str, 
        dest='Xlabel', default=None,
        help="[OPTIONAL] X-label [default: Xattrib value].")
    parser.add_option("--Ylabel", metavar="LABEL", type=str, 
        dest='Ylabel', default=None,
        help="[OPTIONAL] Y-label, [default: Yattrib value].")
    parser.add_option("--Xscale", metavar="SCALE", type=str,
        dest='Xscale', default='log',
        help="[OPTIONAL] X-scale (log, linear), [default: log].")
    parser.add_option("--Yscale", metavar="SCALE", type=str,
        dest='Yscale', default='log',
        help="[OPTIONAL] Y-scale (log, linear), [default: log].")

    # control special behavior of graphs
    parser.add_option("--fit_curve", action='store_true',
        dest='fit_curve', default=False,
        help="fit a curve using generic cost models [default: False].")
    parser.add_option("--guess", action='store_true',
        dest='guess', default=False,
        help="With --fit_curve, will use pre-guessed model coefficients")

    parser.add_option("--avg", action='store_true',
        dest='avg', default=False,
        help="plot averages [default: False].")
    parser.add_option("--exclude", metavar="METHODS", nargs='?', type=str,
        dest='exclude', default=[],
        help="method(s) to exclude from display [default: None].")


    (opt, args) = parser.parse_args()
    OPT = opt

    if opt.output is not None:
        opt.output = opt.output.rstrip('/')
        if not os.path.exists(opt.output):
            os.makedirs(opt.output)

    if opt.csv_path is not None:
        opt.csv_path = opt.csv_path.rstrip('/')
        if not os.path.exists(opt.csv_path):
            os.mkdir(opt.csv_path)

        if not os.path.isdir(opt.csv_path) and os.path.exists(opt.csv_path):
            files = [opt.csv_path]
        elif os.path.isdir(opt.csv_path):
            files = glob.glob(opt.csv_path + "/*.csv")
        else:
            print "Asked to process CSV, but path is not valid."
            exit(-1)
        if len(files) == 0:
            print "Looked for CSV files and didn't find any."
            exit(-1)
        data = processCSV(files)

    if opt.overhead_path is not None:
        d = processOverhead(opt.overhead_path)
        data = data + d

    if opt.Yattrib == "Cost":
        cost_to_tag()
        cost_to_store_tag()
        cost_to_audit()
    else:
        plotData(data, Xattrib=opt.Xattrib, Yattrib=opt.Yattrib,
                 Xlabel=opt.Xlabel, Ylabel=opt.Ylabel,
                 Xscale=opt.Xscale, Yscale=opt.Yscale,
                 fit_curve=opt.fit_curve, average=opt.avg)
