#!/bin/bash

# Simple script for searching wiki from command line
echo -e "Search Runescape Wiki: "
read search_term
search_term_formatted="${search_term// /_}"

url=https://runescape.wiki/w

# Only Firefox supported here.
# Should be easy to change/add other browsers
open -a Firefox "$url/$search_term_formatted"
