#!/bin/bash

# The makeEverything code leaves the LaTeX directory in its "Portable" rather than "Local" state
# Fix that

scriptDir="$(realpath $(dirname "$0"))" # get the path to this script itself

cd "$scriptDir/../BufferStockTheory-Public"

rm -f economics.bib
for f in BufferStockTheory BufferStockTheory-Slides; do
    rm    $f.bib
    touch $f.bib
done
