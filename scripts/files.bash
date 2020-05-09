#!/bin/bash
set -e

sources_filename="$(dirname "$(realpath $0)")/../src/sources.cfg"

sources_pathname=$(realpath "$sources_filename")
sources_root_directory=$(dirname "$sources_pathname")

cd "$sources_root_directory"

work_filename="./work.tmp"