#!/bin/sh
# This script assumes that its grandparent directory is the name of the paper (baseName)
# and the contents of the shared repo are in a subdirectory (named "-Shared")
# of the grandparent directory

scriptDir="$(realpath $(dirname "$0"))" # Parent directory, e.g. BufferStockTheory-make 
baseName=$(basename $(dirname "$scriptDir")) # Name of grandparent directory, e.g. BufferStockTheory

SharedDir="$(realpath "$scriptDir/../$baseName-Shared")" # e.g., BufferStockTheory-Shared

# Journals often insist that there be a version of the paper without the appendix
# and that there be a standalone version of the appendix for posting online

# It's complicated, though, to compile the docs separately yet keep the equation cross-references
# between main body and appendix working; requires the use of \usepackage{xr-hyper} and some tricks
./makePDF-Shareable.sh `realpath $SharedDir`        BufferStockTheory
./makePDF-Shareable.sh `realpath $SharedDir`        BufferStockTheory-NoAppendix
./makePDF-Shareable.sh `realpath $SharedDir`        BufferStockTheory-Appendix
./makePDF-Shareable.sh `realpath $SharedDir`        BufferStockTheory 
./makePDF-Shareable.sh `realpath $SharedDir/Slides` BufferStockTheory-Slides

