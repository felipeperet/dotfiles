#!/usr/bin/env bash

swww-daemon &
swww img ~/Wallpapers/wall.png &

nm-applet --indicator &
blueman-applet &

waybar &
