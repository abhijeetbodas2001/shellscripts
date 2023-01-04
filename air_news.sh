#!/usr/bin/env bash

set -o errexit; set -o nounset; set -o pipefail;
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

# Scrapes the All India Radio page source for national news in regional
# languages, and outputs the URL to the mp3 files for news in given
# languages

curl -s https://newsonair.gov.in/nsd-audio.aspx > /tmp/air_news

# Remove zeroes in the month and day numbers, because that's
# the format used in the files names on the server
date=$(date +%Y)$(date +%Y%m%d | sed "s/20[0-9][0-9]//g" | sed "s/0//g")

# Grab the link to the audio file from the page source for each
# of the following languages.
for language in "Marathi" "Sanskrit" "Kannada"
do
        grep "$language.*$date.*mp3" /tmp/air_news | sed 's/.*src\="\(.*mp3\)".*/\1/'
done

