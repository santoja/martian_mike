#!/bin/sh
echo -ne '\033c\033]0;MartianMike\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/MartianMike.x86_64" "$@"
