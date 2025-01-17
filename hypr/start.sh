#!/usr/bin/env bash

swww-daemon &
swww img ~/Wallpapers/cyber-gruv.png &

nm-applet --indicator &
blueman-applet &

waybar &
