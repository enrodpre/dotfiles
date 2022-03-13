#!/bin/bash

wallpaper=$HOME/wallpapers/$(ls $HOME/wallpapers* | sort -R | head -n1)

xwallpaper --output HDMI-0 --stretch "$wallpaper" --output DVI-D-0 --stretch "$wallpaper"

wal -i "$wallpaper"

reTheme "$wallpaper"

