#!/bin/bash

scriptDir="$(realpath $(dirname "$0"))" # get the path to this script itself

sudo echo 'Authorizing sudo.'

cd $scriptDir

./makeEverything.sh
./postEverything.sh
./makePDF-Local.sh

# The makeEverything code leaves the LaTeX directory in its "Portable" rather than "Local" state
# Fix that

rm -f economics.bib
for f in BufferStockTheory BufferStockTheory-Slides; do
    rm    $f.bib
    touch $f.bib
done

