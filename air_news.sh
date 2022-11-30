#!/usr/bin/env bash

# From template
set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

# Actual script starts here

# Scrapes the All India Radio page source for national news in regional
# languages, and outputs the URL to the mp3 files for news in given
# languages

curl -s https://newsonair.gov.in/nsd-audio.aspx > /tmp/air_news

# The files have dates in them, but the format is wierd
# It is YYYYMMDD, but if DD is between 01 and 09, only one
# digit is used for the date. For example, 20221102 will be
# mentioned as 2022112 in the file name.
# The following line gets today's date in this wierd format.
date=$(date +%Y%m%d | sed "s/\(\([0-9]\)\{6\}\)0\([1-9]\)/\1\3/")

# Grab the link to the audio file from the page source for each
# of the following languages.
for language in "Marathi" "Sanskrit" "Kannada"
do
        grep "$language.*$date.*mp3" /tmp/air_news | sed 's/.*src\="\(.*mp3\)".*/\1/'
done

