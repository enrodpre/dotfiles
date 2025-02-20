#!/usr/bin/env zsh

picom -b &
$HOME/.config/polybar/launch.sh &
xautolock -time 10 -locker "sh $HOME/.config/i3/scripts/autolock_suspend.sh" &
redshift &
xwallpaper --stretch $XDG_DATA_HOME/wallpapers/dark-moon.jpg
