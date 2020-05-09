#!/bin/bash
# Saves the work across the consolidated files.
set -e

sources_filename="./src/sources.cfg"

sources_pathname=$(realpath "$sources_filename")
sources_root_directory=$(dirname "$sources_pathname")

cd "$sources_root_directory"

work_filename="./work.tmp"

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

work_contents=$(cat "$work_filename")

for source_path in "${source_paths[@]}"
do
    start_delimiter="%{{>>"$source_path"}}%"
    end_delimiter="%{{<<"$source_path"}}%"
    
    start_line=$(echo "$work_contents" | awk 'match($0,v){print NR; exit}' v="$start_delimiter")
    ((start_line=start_line+1))
    
    end_line=$(echo "$work_contents" | awk 'match($0,v){print NR; exit}' v="$end_delimiter")
    ((end_line=end_line-1))
    
    contents=$(echo "$work_contents" | sed -n "$start_line,$end_line p;$end_line q")
    
    echo "$contents" > "$source_path"
done
