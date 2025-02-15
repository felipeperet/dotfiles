#!/usr/bin/env bash

swww-daemon &
swww img ~/Wallpapers/gruv-tux.jpg &

nm-applet --indicator &
blueman-applet &

waybar &
