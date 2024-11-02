#!/bin/bash
#
image_dir="$HOME/.config/neofetch/images"
files=("$image_dir"/*)
random_image="${files[RANDOM % ${#files[@]}]}"

echo "$random_image"
