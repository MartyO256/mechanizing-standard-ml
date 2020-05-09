#!/bin/bash
set -e

source "$(dirname "$(realpath $0)")/files.bash"

harpoon --sig "$work_filename"
