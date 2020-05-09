#!/bin/bash
# Consolidates all the files configured in the sources file.
set -e

source "$(dirname "$(realpath $0)")/source-paths.bash"

if [ -s "$work_filename" ]
then
    echo "Fatal error: work file \""$work_filename"\" not empty" >&2
    exit 1
fi

for source_path in "${source_paths[@]}"
do
    start_delimiter="%{{>>"$source_path"}}%"
    end_delimiter="%{{<<"$source_path"}}%"

    echo "$start_delimiter" >> "$work_filename"
    cat "$source_path" >> "$work_filename"
    echo "$end_delimiter" >> "$work_filename"
done
