#!/usr/bin/env bash

swww-daemon &
swww img ~/Wallpapers/Abstract/bluecloud-2.png &

nm-applet --indicator &
blueman-applet &

waybar &
