#!/usr/bin/env bash

awww-daemon &
awww img ~/Wallpapers/Cool/nixOS.png &

nm-applet --indicator &
blueman-applet &

waybar &

systemctl --user start swayosd
