#!/usr/bin/env bash

set -o errexit; set -o nounset; set -o pipefail;
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

# Backs up data from SSD to Hard Drive
# Note to self: Also make sure that everything in ~/code is
# committed and pushed to GitHub

# Paths
HDDpath="/mnt/z"
CmyDataPath="/mnt/c/myData"

# Dirs with many changes (which give long outputs on running
# the script) kept at the end of the list
for dir in\
    "academic"\
    "archive"\
    "games"\
    "misc"\
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

