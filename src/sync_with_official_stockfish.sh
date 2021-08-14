#!/bin/sh
# sync_with_official_stockfish.sh
# Using Windows git.
git='/c/Program Files/Git/bin/git.exe'

# change directory to the path of the script
cd "${0%/*}"

# go to the src directory for Stockfish on my hard drive (edit accordingly)
cd /c/"$HOMEPATH"/Documents/GitHub/Stockfish/src

echo
echo "This command will sync with master of official-stockfish"
echo

echo "Adding official Stockfish's public GitHub repository URL as a remote in my local git repository..."
"$git" remote add     official https://github.com/official-stockfish/Stockfish.git
"$git" remote set-url official https://github.com/official-stockfish/Stockfish.git

echo
echo "Going to my local master branch..."
"$git" checkout master

echo
echo "Downloading official Stockfish's branches and commits..."
"$git" fetch official

echo
echo "Updating my local master branch with the new commits from official Stockfish's master..."
"$git" reset --hard official/master

echo
echo "Pushing my local master branch to my online GitHub repository..."
"$git" push origin master --force

echo
echo "Compiling new master..."
if [ -f ./makefish.sh ] ; then
  ./makefish.sh
else
    echo "Cannot find ./makefish.sh. You probably have to do..."
    echo ""
    echo "git merge msys64"
    echo "git HEAD~1"
    echo "git status"
    echo ""
    echo "This should get the necessary windows build scripts and"
    echo "make the untracked."
fi

# Linux
#make clean
#make build ARCH=x86-64-modern -j 8
#make net

echo
echo "Done."
