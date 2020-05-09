#!/bin/bash
# Saves the work across the consolidated files.
set -e

source "$(dirname "$(realpath $0)")/source-paths.bash"

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
