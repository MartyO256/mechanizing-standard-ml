#!/bin/bash
set -e

sources_filename="./src/sources.cfg"

sources_pathname=$(realpath "$sources_filename")
sources_root_directory=$(dirname "$sources_pathname")

cd "$sources_root_directory"

work_filename="./tmp"

harpoon --sig "$work_filename"
