#! /run/current-system/sw/bin/bash
# Take a screenshot with grim using slurp for selection
filename=$(date +%Y%m%d_%Hh%Mm%Ss)_grim
grim -g "$(slurp)" "/home/sasdelli/Pictures/$filename.png"
