#!/bin/bash

debug=false
two_monitors=false
usermodmap=$HOME/.Xmodmap

xrandr --output HDMI-A-0 --set TearFree on

#  xrandr --output HDMI-0 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DVI-D-0 --mode 1920x1080 --pos 2560x0  --rotate normal --output DP-0 --off --output DP-1 --off
# xrandr --output HDMI-0 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DVI-D-0 

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [[ "$debug" = true ]]
then
  exec i3 -V -d all &>> "$HOME/logs/i3.log" 
else
  exec i3
fi

