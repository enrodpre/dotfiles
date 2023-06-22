#!/bin/bash

DEBUG=false

#xrandr --output HDMI-0 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DVI-D-0 --mode 1920x1080 --pos 2560x0  --rotate normal --output DP-0 --off --output DP-1 --off
xrandr --output HDMI-0 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DVI-D-0 

xmodmap .Xmodmap

picom -bc

$HOME/.config/polybar/launch.sh

if [[ "$DEBUG" = true ]]
then
  exec i3 -V -d all &>> "$HOME/logs/i3.log" 
else
  exec i3
fi

$HOME/.config/i3/scripts/set_theme.sh -r

export MOZ_ENABLE_WAYLAND=1
export CURRENT_PROJECT=$HOME/projects/gameoflife
