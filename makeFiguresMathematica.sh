#!/bin/bash
# Unix bash script to construct all of the mathematical results using Mathematica

# Unless you are running this script on a Mac with its own local Mathematica licence,
# this script will need to be customized so that the shell command WolframKernel
# invokes the Mathematica compuational kernel

# The alternative to a Mac below is a configuration for someone whose machine has been authenticated
# to the Johns Hopkins University department of Economics Mathematica license

scriptDir="$(dirname "$0")" # scriptDir=/Volumes/Data/Papers/BufferStockTheory
cd $scriptDir/BufferStockTheory-Latest

rm -Rf Figures
mkdir  Figures

pwd

cd $scriptDir/Code/Mathematica/Results/BufferStockTheory

echo
echo 'In directory:'
echo ''
echo `pwd`
echo ''
echo "Running Mathematica code which should generate all the paper's main results.  Output goes to unix console as well as doAll.out and doApndxLiqConstr.out"
# the tee command allows the output to go both to the console and to a file:
# http://unix.stackexchange.com/questions/41246/how-to-redirect-output-to-multiple-log-files

# Suppress any line containing Graphics because Graphics are not visible in a text output file
if [ `uname` == "Darwin" ]; then # On a Mac, the kernel is at /Applications/Mathematica.app/Contents/MacOS/
    /Applications/Mathematica.app/Contents/MacOS/WolframKernel -noprompt < doAll.m            | tee doAll.out            | grep -v Graphics 
    /Applications/Mathematica.app/Contents/MacOS/WolframKernel -noprompt < doApndxLiqConstr.m | tee doApndxLiqConstr.out | grep -v Graphics 
else # must be a generic Unix machine
    ping -c 2 -w 5 jhas.win.ad.jhu.edu > /dev/null # Try to contact the JHU license server for Mathematica
    if [ $? -eq 0 ]; then # the prior command succeeded (producing an 'exit status' of 0 in the $? variable)
                                                 WolframKernel -noprompt < doAll.m            | tee doAll.out            | grep -v Graphics 
                                                 WolframKernel -noprompt < doApndxLiqConstr.m | tee doApndxLiqConstr.out | grep -v Graphics
    else
	echo ''
	echo 'Could not contact the JHU Mathematica license server; make sure you are connected to the campus VPN and retry.'
	echo ''
	exit 1
    fi
fi

cd $scriptDir/BufferStockTheory-Latest/Code/Python

ipython ./BufferStockTheory.py
