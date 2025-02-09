#!/usr/bin/env bash

swww-daemon &
swww img ~/Wallpapers/gruv-mountains.jpg &

nm-applet --indicator &
blueman-applet &

waybar &
