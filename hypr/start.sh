#!/usr/bin/env bash

swww-daemon &
swww img ~/Wallpapers/gruv.png &

nm-applet --indicator &
blueman-applet &

waybar &
