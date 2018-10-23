#!/bin/bash
# Unix bash script to construct figures using Econ-ARK/HARK toolkit

scriptDir="$(dirname "$0")" # scriptDir=/Volumes/Data/Papers/BufferStockTheory
cd $scriptDir/../BufferStockTheory-Latest/Code/Python

ipython ./BufferStockTheory.py