#!/usr/bin/env bash

# From template
set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

# Actual script starts here

# `n` in rsync is for "DRY RUN". Remove it and run again when
# dry run results are satisfactory

# Paths
HDDpath="/mnt/z"

# First, handle data to be copied from WSL
WSLHomeDirectory="/home/abhijeetbodas2001"

printf "\n\n\n\n\n"
echo "Copying individual files from WSL home"
for file in\
    ".bashrc"\
    ".bash_aliases"\
    ".bash_profile"\
    ".bash_history"\
    ".inputrc"\
    ".gitconfig"\
    ".vimrc"
do
    echo $file
    rsync -t $WSLHomeDirectory"/"$file $HDDpath
done

printf "\n\n\n\n\n"
echo "Copying folders from WSL"
for dir in\
    ".config"
    do
    # May need to copy "code" also, but prefer backing up on GitHub instead
    printf "\n\n"
    echo "Starting "$dir" ----------------------------------------"

    rsync -a --delete $WSLHomeDirectory"/"$dir"/" $HDDpath"/"$dir"/"

done

# Now, copy data from SSD (Windows Filesystem)
CmyDataPath="/mnt/c/myData"

printf "\n\n\n\n\n"
echo "Copying folders from Windows filesystem"
# Dirs with many changes (which give long outputs on running
# the script) kept at the end of the list
for dir in\
    "academic"\
    "archive"\
    "games"\
    "Music"\
    "Pictures"\
    "Public"\
    "Screenshots"\
    "Templates"\
    "notes"\
    "Videos"\
    "Webcam"
do
    printf "\n\n"
    echo "Starting "$dir" ----------------------------------------"

    rsync -a -v --delete $CmyDataPath"/"$dir"/" $HDDpath"/"$dir"/"

done
