#!/bin/sh
# This script assumes that the contents of the paper's repo are in a subdirectory (named "Latest")
# of the directory the script is in

# if [ $# -ne 1 ]; then
#     echo "usage:   ${0##*/} <tex file>"
#     echo "example: ${0##*/} BufferStockTheory-Slides"
#     exit 1
# fi

# jobName=$1

scriptDir="$(dirname "$0")"
cd $scriptDir/../BufferStockTheory-Latest

rm economics.bib # This should be obtained via kpsewhich from the system config
for jobName in BufferStockTheory Slides/BufferStockTheory-Slides; do
    rm -f $jobName.bib
    rm -f $jobName-Add.bib
    touch $jobName.bib 
    touch $jobName-Add.bib
    pdflatex --shell-escape "\newcommand\UseOption{Public}\nonstopmode\input{$jobName}"
    bibtex   $jobName
    pdflatex --shell-escape "\newcommand\UseOption{Public}\nonstopmode\input{$jobName}"
    pdflatex --shell-escape "\newcommand\UseOption{Public}\nonstopmode\input{$jobName}"
    pdflatex --shell-escape "\newcommand\UseOption{Public}\nonstopmode\input{$jobName}"
    bibexport -o $jobName.bib $jobName
done

rm *bib-save* # Clean up potential junk files
