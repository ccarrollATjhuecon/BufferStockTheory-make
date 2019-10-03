#!/bin/bash

# Construct BufferStockTheory-Public from repo, which must already exist and be empty in the user's github account

if [ $# -ne 3 ]; then
    echo "usage:   ${0##*/} <path> <GitHubID> create|update "
    echo "example: ${0##*/} ~/GitHub/ccarrollATjhuecon/BufferStockTheory ccarrollATjhuecon create"
    exit 1
fi

pathLocalToReposRemote=$1
GitHubID=$2
option=$3

scriptDir="$(dirname "$0")" # get the path to this script itself
# scriptDir=/Volumes/Data/GitHub/ccarrollATjhuecon/Methods/Data/Papers/BufferStockTheory/BufferStockTheory-make ; pathLocalToReposRemote=~/GitHub/ccarrollATjhuecon ; option=create
# scriptDir=/Volumes/Data/Papers/BufferStockTheory/BufferStockTheory-make ; pathLocalToReposRemote=~/GitHub/ccarrollATjhuecon ; option=create
# scriptDir=~/Papers/BufferStockTheory/BufferStockTheory-make ; option=create ; pathLocalToReposRemote=~/GitHub/ccarrollATjhuecon
scriptRoot="$(realpath "$scriptDir"/..)" # Assume the scriptRoot is one level up
nameRoot="$(basename  "$scriptRoot")" # Assume the base name of the project is the name of the root directory

# echo $username
# echo scriptDir=$scriptDir
# echo root=$root
# echo name=$nameRoot

if [ "$option" == "create" ]; then
    repo_local=$pathLocalToReposRemote/$nameRoot-Public
    if [ ! -e $repo_local ]; then
	mkdir -p $repo_local
    else
	msg='Local repo directory already exists; hit return to proceed anyway, C-c to stop'
	echo $msg
	read answer 
    fi
fi

cd $scriptDir

if [ "$option" == "create" ]; then
    mkdir -p $pathLocalToReposRemote/$nameRoot-Public
    rsync -L -azh -vv --delete-before --delete-excluded --inplace  --exclude-from=$scriptDir/BufferStockTheory-Public-Excludes-To-Delete.txt --force $scriptRoot/$nameRoot-Shared/ $pathLocalToReposRemote/$nameRoot-Public
else
    rsync -L -azh -vv --delete-before                   --inplace  --exclude-from=$scriptDir/BufferStockTheory-Public-Excludes-To-Ignore.txt --force $scriptRoot/$nameRoot-Shared/ $pathLocalToReposRemote/$nameRoot-Public
fi

cd $pathLocalToReposRemote/$nameRoot-Public
# strip everything between begin{Private} and end{Private}, remove all lines labeled PrivateMsg, and remove all comments
for f in $(find . -name '*.tex')
do
    sed '/begin{Private}/,/end{Private}/d' $f > $f-tmp # Delete everything in a {Private} environment 
    grep -v PrivateMsg $f-tmp > $f-tmp2                # Delete all lines marked as PrivateMsg
    sed '/%%/d' $f-tmp2 > $f                           # Remove all comments
    rm $f-tmp $f-tmp2                                  # Clean up
done

cd $repo_local

if [ -e /usr/local/texlive/texmf-local/ ]; then
    rsync -L -azh -vv --delete-before --delete-excluded --inplace `realpath /usr/local/texlive/texmf-local` $repo_local
else
    echo '' ; echo 'Unable to install the texmf-local tools; aborting'
    exit 1
fi

# if [ "$option" == "create" ]; then
#     remoteExists="$(git ls-remote https://github.com/$GitHubID/$nameRoot-Public.git)"

#     if [ $? -ne 0 ]; then 
# 	echo '' ; echo 'Remote repo 'https://github.com/$GitHubID/$nameRoot-Public.git' does not exist.  Create it and hit return to continue.'
# 	read answer
#     fi

#     # Make suitable gitignore
#     cd $repo_local

#     cp  $scriptDir/.gitignore-latex-emacs-macos .gitignore

#     echo "# "$nameRoot" is the public repo for the paper "$nameRoot  > README.md
#     git init
#     git add --all
#     git commit -m "First version of "$nameRoot" constructed from "$pathLocalToReposRemote-Shared
#     git remote add origin https://github.com/$GitHubID/$nameRoot-Public.git
#     git push -u origin master

#     # git submodule add https://github.com/llorracc/BufferStockTheory Shared

# fi
