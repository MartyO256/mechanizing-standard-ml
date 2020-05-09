#!/bin/bash
# Consolidates all the files configured in the sources file.
set -e

sources_filename="./src/sources.cfg"

sources_pathname=$(realpath "$sources_filename")
sources_root_directory=$(dirname "$sources_pathname")

cd "$sources_root_directory"

work_filename="./work.tmp"
if [ -s "$work_filename" ]
then
    echo "Fatal error: work file \""$work_filename"\" not empty" >&2
    exit 1
fi

comment_pattern="^[[:space:]]*%.*$"

source_paths=()
IFS=$'\r\n'
while read -r line
do
    if [[ ! "$line" =~ $comment_pattern ]]
    then
        source_paths+=("$line")
    fi
done < "$sources_pathname"

for source_path in "${source_paths[@]}"
do
    start_delimiter="%{{>>"$source_path"}}%"
    end_delimiter="%{{<<"$source_path"}}%"

    echo "$start_delimiter" >> "$work_filename"
    cat "$source_path" >> "$work_filename"
    echo "$end_delimiter" >> "$work_filename"
done
