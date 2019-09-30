#!/bin/bash

scriptDir="$(dirname "$0")"
cd $scriptDir/../BufferStockTheory-Shared

git fetch
git status

echo '' ; echo ''
echo 'To post your changes, from a shell in the BufferStockTheory-Shared directory, please do:'
echo ''
echo 'git add .'
echo 'git commit -m [commit message]'
echo 'git push'
echo ''
echo ''
echo 'Hit return when done, C-c to abort'
read answer


