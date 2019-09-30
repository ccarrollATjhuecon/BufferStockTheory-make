#!/bin/bash

scriptDir="$(dirname "$0")" # scriptDir=/Volumes/Data/Papers/BufferStockTheory

journal=TheOnion

cd $scriptDir/../BufferStockTheory-Shared/Private/$journal

pdflatex --shell-escape "\newcommand\UseOption{FromShell}\input{Submit.tex}"
bibtex   Submit
pdflatex --shell-escape "\newcommand\UseOption{FromShell}\input{Submit.tex}"
pdflatex --shell-escape "\newcommand\UseOption{FromShell}\input{Submit.tex}"
pdflatex --shell-escape "\newcommand\UseOption{FromShell}\input{Submit.tex}"

