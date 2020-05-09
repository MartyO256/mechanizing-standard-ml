#!/bin/bash
set -e

source "$(dirname "$(realpath $0)")/files.bash"

comment_pattern="^[[:space:]]*%.*$"

source_paths=()
IFS=$'\r\n'
while read -r line
do
    if [[ ! "$line" =~ $comment_pattern ]] && [[ ! -z "$line" ]]
    then
        source_paths+=("$line")
    fi
done < "$sources_pathname"