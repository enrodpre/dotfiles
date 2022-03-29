#!/bin/bash

wallpapers_folder=$HOME/.config/wallpapers

wallpaper=$(find $wallpapers_folder -type f | sort -R | head -n1)

xwallpaper --output HDMI-0 --stretch "$wallpaper" --output DVI-D-0 --stretch "$wallpaper"

wal -i "$wallpaper"

reTheme "$wallpaper"

