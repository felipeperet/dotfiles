#!/usr/bin/env bash

swww-daemon &
swww img ~/Wallpapers/Abstract/blur.png &

nm-applet --indicator &
blueman-applet &

waybar &
