#!/usr/bin/env bash

swww-daemon &
swww img ~/Wallpapers/Abstract/procedural.png &

nm-applet --indicator &
blueman-applet &

waybar &
