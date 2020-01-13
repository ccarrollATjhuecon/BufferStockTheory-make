#!/bin/bash
# Unix bash script to construct figures using Econ-ARK/HARK toolkit

scriptDir="$(realpath $(dirname "$0"))" # Parent directory, e.g. BufferStockTheory-make

baseName=$(basename $(dirname "$scriptDir")) # Name of grandparent directory, e.g. BufferStockTheory or BST

SharedDir="$(realpath "$scriptDir/../$baseName-Shared")" # e.g., BufferStockTheory-Shared or BST-Shared

toolsDir=/Methods/Tools/Scripts # Extra tools

cd $scriptDir/../"$baseName"-Shared/Code/Python

# Running the code should create the figures
ipython ./BufferStockTheory.py
