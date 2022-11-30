#!/usr/bin/env bash

# From template
set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

# Actual script starts here

# Run the below inside the /Music directory
find -regex ".*\.mp3$" \                                            # Get all mp3 files
        -execdir ffmpeg -i '{}' -map a '{}'"ffmpeg.mp3" \; \        # Remove thumbnail and save as origname.mp3ffmpeg.mp3
        -execdir rm "{}" \; \                                       # Delete origname.mp3
        -execdir mv "{}""ffmpeg.mp3" "{}" \;                        # Rename origname.mp3ffmpeg.mp3 to origname.mp3
