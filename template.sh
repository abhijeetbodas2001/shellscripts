#!/usr/bin/env bash

# Credit: https://sharats.me/posts/shell-script-best-practices/

# When some command fails, exit instead of continuing
# with the rest of the script
set -o errexit

# Make the script fail if an unset variable is accessed
set -o nounset

# Ensure that a pipeline command is treated as failed,
# even if one command in the pipeline fails
set -o pipefail

# Allows "enabling" debug mode by running the script as
# `TRACE=1 ./script.sh`
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

# Change to the script's directory
# cd "$(dirname "$0")"
