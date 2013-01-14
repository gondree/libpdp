#! /usr/bin/python

"""
Plot and analyze POR experimental data.

"""
import cPickle as pickle
import numpy as np
from pylab import *
from scipy.optimize import curve_fit
from collections import OrderedDict
from scipy.interpolate import LinearNDInterpolator
import matplotlib.pyplot  as plt
import pprint
import argparse


###############################################################################
#
# Generic economic cost models
#

def num_gets_cost(x, c0, c1, c2, c3=80):
    """ A cost function for file size vs. no. of GETs.
    
        Ex: ./analysis.py --exp_path ../data/all-times-file-size-ec2/ --Xattrib 'File size (kb)' --Yattrib 'GET' --Xlabel 'File size (kb)' --fit_curve
    """
    b = 4096     # block size
    kb = 2**10   # bytes in kb
    case = str(M).strip()
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
    
        Ex: ./analysis.py --exp_path ../data/all-times-file-size/ --Xattrib 'File size (kb)' --Yattrib 'Create tag' --Xlabel 'File size (kb)' --fit_curve
    """
    b = 4096     # block size
    kb = 2**10   # bytes in kb
    ans = []
    case = str(M).strip()
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

def create_proof_cost(x, c0, c1, c2, c3, c4, c5):
    """ A cost function for file size vs. tagging time.
    
        Ex: ./analysis.py --exp_path ../data/all-times-file-size/ --Xattrib 'File size (kb)' --Yattrib 'Create proof' --Xlabel 'File size (kb)' --fit_curve
    """
    b = 4096     # block size
    kb = 2**10   # bytes in kb
    ans = []
    case = str(M).strip()
    if case == "MAC-PDP":
        num_challenges = 460
        ans = [c0 * num_challenges * b for f in x]
    elif case == "APDP":
        b = 16384
        num_challenges = 460
        ans = [c0 * num_challenges * b for f in x]
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


def verify_proof_cost(x, c0, c1, c2, c3, c4, c5):
    """ A cost function for file size vs. verifying time.
    
        Ex: ./analysis.py --exp_path ../data/all-times-file-size/ --Xattrib 'File size (kb)' --Yattrib 'Verify file' --Xlabel 'File size (kb)' --fit_curve
    """
    b = 4096     # block size
    kb = 2**10   # bytes in kb
    ans = []
    case = str(M).strip()
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


def select_fun():
    """ Set up the cost function and any guesses to use for fitting curves
    """
    guess = None
    f = None
    case = str(M).strip()
    if (args.Xattrib == "File size (kb)" and 
        args.Yattrib == "Create tag"):
        f = create_tag_cost
    elif (args.Xattrib == "File size (kb)" and 
          args.Yattrib == "GET"):
        f = num_gets_cost
    elif (args.Xattrib == "File size (kb)" and 
        args.Yattrib == "Create proof"):
        f = create_proof_cost
        if case == "MAC-PDP":
            f = create_proof_cost
            guess = (10**(-7), 1, 1, 1, 1, 1)
        elif case == "APDP":
            f = create_proof_cost
            guess = (10**(-8), 1, 1, 1, 1, 1)
        elif case == "CPOR":
            f = create_proof_cost
            guess = (10**(-5), 10**(-6), 1, 1, 1, 1)
    elif (args.Xattrib == "File size (kb)" and 
        args.Yattrib == "Verify file"):
        f = verify_proof_cost
    return f, guess





###############################################################################
#
# Main
#
parser = argparse.ArgumentParser(description='Perform PDP data analysis.')
parser.add_argument("--exp_path", metavar="PATH", type=str, 
                    help="path to experiment directory to analyze.")
parser.add_argument("--Xattrib", metavar="ATTRIB", type=str, 
                    help="X axis attribute.")
parser.add_argument("--Yattrib", metavar="ATTRIB", type=str, 
                    help='Y axis attribute.')
parser.add_argument("--Xscale", metavar="SCALE", type=str, default="log",
                    help="[OPTIONAL] X-scale (log, linear), [default: log].")
parser.add_argument("--Xlabel", metavar="LABEL", type=str, 
                    help="[OPTIONAL] X-label [default: Xattrib value].")
parser.add_argument("--Yscale", metavar="SCALE", type=str, default='log',
                    help="[OPTIONAL] Y-scale (log, linear), [default: log].")
parser.add_argument("--Ylabel", metavar="LABEL", type=str, 
                    help="[OPTIONAL] Y-label, [default: Yattrib value].")
parser.add_argument("--exclude", metavar="METHODS", nargs='?', 
                    default=[], type=str, 
                    help="method(s) to exclude from display [default: None].")
parser.add_argument("--fit_curve", action='store_true', default=False, 
                    help="fit a curve using generic cost models "
                         "[default: False].")
args = parser.parse_args()


if __name__=="__main__":
    if args.exp_path is None:
        parser.print_help()
        exit()
    
    data = pickle.load(open(args.exp_path+'/exp_data.pickle','rb'))
    
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

    print attrib_str
    
    #
    # Ensure methods are correct
    #
    All = OrderedDict()
    shown_methods = []
    for i,M in enumerate(Methods):
        if (M not in args.exclude and 
            args.Xattrib in Keys[i] and args.Yattrib in Keys[i]):
            shown_methods.append(M)
            All[M+':X'] = []
            All[M+':Y'] = []
    
    idx = 0
    for point in data:
        M = point['Metadata'][0].split(':')[0]
        if M in shown_methods:
            # Not every method has the same attributes
            try:
                if args.Xattrib != False:
                    All[M+':X'].append(point[args.Xattrib])
                else:
                    All[M+':X'].append(idx)
                    idx += 1
            except KeyError: 
                # Safe default (this shouldn't happen)
                All[M+':X'].append(0.00001)
            try:
                All[M+':Y'].append(np.mean(point[args.Yattrib]))
            except KeyError:
                All[M+':Y'].append(0.00001)

    #
    # Begin plotting
    #
    fig = plt.figure()
    p = fig.add_subplot(1,1,1)
    
    # set scaling
    if args.Xscale != 'linear':
        p.set_xscale('log', basex=2)
    if args.Yscale != 'linear':
        p.set_yscale('log', basey=2)
    
    # Give methods consistent symbology
    point_colors = ['ro','bs','g^','yp']
    avail_colors = ['r', 'b', 'g', 'y']

    # Plot 'em
    p.hold(True)
    for M in shown_methods:
        dot_style = point_colors[Methods.index(M)]
        p.plot(All[M+':X'], All[M+':Y'], dot_style)
    p.hold(False)
    
    # Fit curves
    if args.fit_curve:
        print "Params for curve fitting:"
        for M in shown_methods:          
            # Select the right function to fit
            fit_func, guess = select_fun()
            
            # Fit and plot it
            xdata = [float64(x[0]) for x in All[M+':X']]
            ydata = [float64(y) for y in All[M+':Y']]
            
            opt, cov = curve_fit(fit_func, xdata, ydata, p0=guess)
            xdata = sort(xdata)
            ydata = fit_func(xdata, *opt)
            
            color = avail_colors[Methods.index(M)]
            p.hold(True)
            p.plot(xdata, ydata, color=color)
            p.hold(False)
            print "\t", M, opt

    # Put legend above plot
    p.legend(shown_methods, loc='upper center', 
             bbox_to_anchor=(0.5, 1.1), fancybox=True, shadow=True, ncol=5)
    
    # Apply labels
    if args.Xlabel != None:
        p.set_xlabel(args.Xlabel)
    else:
        p.set_xlabel(args.Xattrib)
    
    if args.Ylabel != None:
        p.set_ylabel(args.Ylabel)
    else:
        p.set_ylabel(args.Yattrib)

    show()