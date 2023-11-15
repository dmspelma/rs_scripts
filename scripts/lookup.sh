#!/bin/bash
#
# Simple script for hiscore lookup and compare

# Get the current script's directory
current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Move up one directory
parent_dir="$(dirname "$current_dir")"

# Specify the file to run
file_to_run="lib/rs_scripts/lookup.rb"

# Run the file from the parent directory
ruby "$parent_dir/$file_to_run"
