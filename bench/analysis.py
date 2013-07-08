#! /usr/bin/python
import os, glob, csv, time, math
import cPickle as pickle
import numpy as np
from numpy import array, float64
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit
from scipy.interpolate import LinearNDInterpolator
from optparse import OptionParser
from collections import OrderedDict
from pprint import pprint

###############################################################################
#
# Support Functions
#
SCHEME = None

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
                    elif h[j] == 'Timestamp':
                        # column j is a timestamp
                        t = time.strptime(x, '%a %b %d %H:%M:%S %Y')
                        data[-1][h[j]].append(int(time.mktime(t)))
                    else:
                        # column data is just a float, int, string
                        data[-1][h[j]].append(x)
        f.close()
    return data

###############################################################################
#
# Generic economic cost models, for curve fitting
#

def num_gets_cost(x, c0, c1, c2, c3=80):
    """ A cost function for file size vs. no. of GETs.
    
        Ex: ./analysis.py --exp_path ../data/all-times-file-size-ec2/ 
        --Xattrib 'File size (kb)' --Yattrib 'GET' 
        --Xlabel 'File size (kb)' --fit_curve
    """
    b = 4096     # block size
    kb = 2**10   # bytes in kb
    case = SCHEME
    if case == "MAC-PDP":
        ans = [min(c3, c1*math.ceil(f*kb/b)) for f in x]
        ans = [c0 + max(c2, i) for i in ans]
    elif case == "APDP":
        b = 16384
        ans = [min(c1*math.ceil(f*kb/b), c3) for f in x]
        ans = [c0 + max(c2, i) for i in ans]
    elif case == "CPOR":
        ans = [min(c1*math.ceil(f*kb/b), c3) for f in x]
        ans = [c0 + max(c2, i) for i in ans]
    elif case == "SEPDP":
        ans = [min(c1*math.ceil(f*kb/b), c3) for f in x]
        ans = [c0 + max(c2, i) for i in ans]
    else:
        ans = [0 for i in x]
    return array(ans)

def create_tag_cost(x, c0, c1, c2, c3, c4, c5):
    """ A cost function for file size vs. tagging time.
    
        Ex: ./analysis.py --exp_path ../data/all-times-file-size/ 
        --Xattrib 'File size (kb)' --Yattrib 'Create tag' 
        --Xlabel 'File size (kb)' --fit_curve
    """
    b = 4096     # block size
    kb = 2**10   # bytes in kb
    ans = []
    case = SCHEME
    if case == "MAC-PDP":
        ans = [c0 + c1 * f/b for f in x]
    elif case == "APDP":
        b = 16384
        ans = [c0 + c1 * f/b for f in x]
    elif case == "CPOR":
        ans = [c0 + c1 * f/b for f in x]
    elif case == "SEPDP":
        magic = 512
        for f in x:
            y = c0 + c1 * f/b
            if f * kb / b >= magic:   # cost function switches at 2**11 kb
                y = c2
            ans.append(y)
    else:
        ans = [0 for i in x]
    return array(ans)

def create_tag_block_cost(x, c0, c1, c2, c3, c4, c5):
    """ A cost function for file size vs. tagging time.
    
        Ex: ./analysis.py --exp_path ../data/all-times-block-size/ 
        --Xattrib 'Block size' --Yattrib 'Create tag' 
        --Xlabel 'Block size (bytes)' --fit_curve
    """
    f = 2**15    # file size in kb
    kb = 2**10   # bytes in kb
    ans = []
    case = SCHEME
    if case == "MAC-PDP":
        ans = [c0 + c1 * f * kb/b for b in x]
    elif case == "APDP":
        b = 16384
        ans = [c0 + c1 * f * kb/b for b in x]
    elif case == "CPOR":
        ans = [c0 + c1 * f * kb/b for b in x]
    elif case == "SEPDP":
        magic = 512
        for b in x:
            y = c0 + c1 * f/b
            if f * kb / b >= magic:   # cost function switches at 2**16 kb
                y = c2
            ans.append(y)
    else:
        ans = [0 for i in x]
    return array(ans)

def create_proof_cost(x, c0, c1, c2, c3, c4, c5):
    """ A cost function for file size vs. tagging time.
    
        Ex: ./analysis.py --exp_path ../data/all-times-file-size/ 
        --Xattrib 'File size (kb)' --Yattrib 'Create proof' 
        --Xlabel 'File size (kb)' --fit_curve
    """
    b = 4096     # block size
    kb = 2**10   # bytes in kb
    ans = []
    case = SCHEME
    if case == "MAC-PDP":
        magic = 460
        ans = [c0 * magic for f in x]
    elif case == "APDP":
        b = 16384
        magic = 460
        ans = [c0 * magic for f in x]
    elif case == "CPOR":
        # ans = [c0 + c1 * f/b for f in x]
        magic = 80
        for f in x:
            y = c0 + c1 * f/b
            if f * kb / b >= magic:
                y = c2
            ans.append(y)
    elif case == "SEPDP":
        magic = 512
        for f in x:
            y = c0 + c1 * f/b
            if f * kb / b >= magic:   # cost function switches at 2**11 kb
                y = c2
            ans.append(y)
    else:
        ans = [0 for i in x]
    return array(ans)


def verify_proof_cost(x, c0, c1, c2, c3, c4, c5):
    """ A cost function for file size vs. verifying time.
    
        Ex: ./analysis.py --exp_path ../data/all-times-file-size/ 
        --Xattrib 'File size (kb)' --Yattrib 'Verify file' 
        --Xlabel 'File size (kb)' --fit_curve
    """
    b = 4096     # block size
    kb = 2**10   # bytes in kb
    ans = []
    case = SCHEME
    if case == "MAC-PDP":
        num_challenges = 460
        for f in x:
            y = c0 + c1 * f/b
            if f * kb / b >= num_challenges:
                y = c2
            ans.append(y)
    elif case == "APDP":
        b = 16384
        num_challenges = 460
        for f in x:
            y = c0 + c1 * f/b
            if f * kb / b >= num_challenges:
                y = c2
            ans.append(y)
    elif case == "CPOR":
        ans = [c0 for f in x]
    elif case == "SEPDP":
        ans = [c0 for f in x]
    else:
        ans = [0 for i in x]
    return array(ans)


def select_fun(case=None, Xattrib=None, Yattrib=None):
    """ Set up the cost function and any guesses to use for fitting curves
    """
    global SCHEME
    SCHEME = case # a global hack for fit_func global params
    guess = None
    f = None
    if (Xattrib == "File size (kb)" and Yattrib == "Create tag"):
        f = create_tag_cost
    if (Xattrib == "Block size" and Yattrib == "Create tag"):
        f = create_tag_block_cost
        if case == "MAC-PDP":
            guess = (0.25, 0, 1, 1, 1, 1)
        elif case == "SEPDP":
            guess = (0, 1, 1.148**(-2), 1, 1, 1)
        elif case == "CPOR":
            guess = (.5, 0, 1, 1, 1, 1)
    elif (Xattrib == "File size (kb)" and Yattrib == "GET"):
        f = num_gets_cost
    elif (Xattrib == "File size (kb)" and Yattrib == "Create proof"):
        f = create_proof_cost
        if case == "MAC-PDP":
            guess = (2**(-24), 1, 1, 1, 1, 1)
        elif case == "APDP":
            guess = (10**(-8), 1, 1, 1, 1, 1)
        elif case == "CPOR":
            guess = (10**(-5), 10**(-6), 1, 1, 1, 1)
    elif (Xattrib == "File size (kb)" and Yattrib == "Verify file"):
        f = verify_proof_cost
    return f, guess


###############################################################################
#
# A generic plotting function
#

def plotData(data, Xattrib=False, Yattrib=False, Xscale='log', Yscale='log',
             Xlabel=None, Ylabel=None, exclude=[], fit_curve=False,
             average=False, interactive=False, output='figure.png'):
    #
    # Print available attributes
    #
    Methods = []
    Keys = []
    Num_attrib = []
    for point in data:
        mn = point['Metadata'][0].split(':')[0]
        if mn not in Methods:
            Methods.append(mn)
            Keys.append(point.keys())
            Num_attrib.append(len(point.keys()))
    Methods.sort()

    attrib_str = "\n"
    for m in Methods:
        attrib_str += '%30s' % m
    attrib_str += '\n'
    for m in range(len(attrib_str)-1):
        attrib_str += '='
    attrib_str += '\n'
    
    for i in range(max(Num_attrib)):
        for j in range(len(Methods)):
            try:
                attrib_str += '    |%25s' % Keys[j][i]
            except IndexError:
                attrib_str += '    |%25s' % ' '
        attrib_str += '\n'
    if interactive:
        print attrib_str
    
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
        M = point['Metadata'][0].split(':')[0]
        if M in shown_methods:
            # Not every method has the same attributes
            try:
                if Xattrib != False:
                    All[M+':X'].append(point[Xattrib])
                else:
                    All[M+':X'].append(idx)
                    idx += 1
            except KeyError: 
                # Safe default (this shouldn't happen)
                All[M+':X'].append(0.00001)
            try:
                All[M+':Y'].append(np.mean(point[Yattrib]))
            except KeyError:
                All[M+':Y'].append(0.00001)

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
    
    # Give methods consistent symbology
    point_colors = {'MAC-PDP':'ro', 'APDP':'bs', 
                    'CPOR':'g^', 'SEPDP':'yp', 'PDP':'bs'}
    avail_colors = {'MAC-PDP':'r', 'APDP':'b', 
                    'CPOR':'g', 'SEPDP':'y', 'PDP': 'b'}
    method_name = {'MAC-PDP':'MAC-PDP', 'APDP':'APDP', 
                    'CPOR':'CPOR', 'SEPDP':'SEPDP', 'PDP': 'APDP'}

    # Plot 'em
    p.hold(True)
    for M in shown_methods:
        p.plot(All[M+':X'], All[M+':Y'], point_colors[M])
    p.hold(False)
    #
    # Fit curves
    #
    if fit_curve:
        print "Params for curve fitting:"
        for M in shown_methods:

            # Select the right function to fit
            fit_func, guess = select_fun(case=method_name[M], 
                                         Xattrib=Xattrib, Yattrib=Yattrib)
            # Fit and plot it
            xdata = [float64(x[0]) for x in All[M+':X']]
            ydata = [float64(y) for y in All[M+':Y']]
            
            opt, cov = curve_fit(fit_func, xdata, ydata, p0=guess)

            xdata = np.sort(xdata)
            ydata = fit_func(xdata, *opt)

            color = avail_colors[M]
            p.hold(True)
            p.plot(xdata, ydata, color=color)
            p.hold(False)

            print fit_func.__name__+"() :"
            print "\t", M, opt

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

    if interactive:
        plt.show()
    elif output is not None:
        plt.savefig(output, bbox_inches=0)
    plt.close()


###############################################################################
#
# Main
#
if __name__=="__main__":
    SCRIPTPATH = os.path.dirname(os.path.abspath(__file__))
    data = None

    parser = OptionParser(description='Perform PDP data analysis.')
    # file options
    parser.add_option("--process-csv", action='store_true',
        dest="process_csv", default=False,
        help="select to process raw CSV data")
    parser.add_option("--csv-data", metavar="PATH", type=str, 
        dest='csv_path', default=None,
        help="path to directory holding CSV data.")
    parser.add_option("--pickle-data", metavar="FILENAME", type=str,
        dest="pickle_path", default=None,
        help="path to intermediate data file to write/read")
    parser.add_option("--output", metavar="PATH", type=str,
        dest='output', default=SCRIPTPATH+"/output/figure.png",
        help="path to directory to hold all output data.")
    # graph options
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
    parser.add_option("--fit_curve", action='store_true',
        dest='fit_curve', default=False,
        help="fit a curve using generic cost models [default: False].")
    parser.add_option("--avg", action='store_true',
        dest='avg', default=False,
        help="plot averages [default: False].")
    parser.add_option("--interactive", "-i", action='store_true',
        dest='interactive', default=False,
        help="If selected, will show the graph to screen")
    parser.add_option("--exclude", metavar="METHODS", nargs='?', type=str,
        dest='exclude', default=[],
        help="method(s) to exclude from display [default: None].")
    (opt, args) = parser.parse_args()

    if opt.csv_path is not None:
        opt.csv_path = opt.csv_path.rstrip('/')
        if not os.path.exists(opt.csv_path):
            os.mkdir(opt.csv_path)

    if opt.process_csv is True and opt.csv_path is None:
        print "Asked to process CSV data, but not given a path to it."
        exit(-1)

    if opt.process_csv is True:
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
        if opt.pickle_path is not None:
            pickle.dump(data, open(opt.pickle_path,'wb'))

    if opt.process_csv is False and opt.pickle_path is None:
        print "Not processing CSV data, but not given any pickled inputs."
        exit(-1)
    elif opt.process_csv is False and not os.path.exists(opt.pickle_path):
        print "%s does not exist" %(opt.pickle_path)
        exit(-1)
    elif opt.process_csv is False:
        data = pickle.load(open(opt.pickle_path,'rb'))

    plotData(data, Xattrib=opt.Xattrib, Yattrib=opt.Yattrib,
            Xlabel=opt.Xlabel, Ylabel=opt.Ylabel,
            Xscale=opt.Xscale, Yscale=opt.Yscale,
            fit_curve=opt.fit_curve, average=opt.avg,
            output=opt.output, interactive=opt.interactive)
