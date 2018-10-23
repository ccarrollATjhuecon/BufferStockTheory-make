#!/bin/bash
# Creates all the figures for the paper, then the journal interactions, then makes an archive
# and finally (optionally) updates the GitHub version

cd "$(dirname "$0")" # http://stackoverflow.com/questions/3349105/how-to-set-current-working-directory-to-the-directory-of-the-script

#./makeFiguresMathematica.sh
./makeFiguresHARK.sh
./makeJournalStuff.sh
./makePDF-Portable.sh

