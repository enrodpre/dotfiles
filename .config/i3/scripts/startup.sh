#!/usr/bin/env zsh

picom -b &
$HOME/.config/polybar/scripts/launch.sh &
xautolock -time 10 -locker "sh $HOME/.config/i3/scripts/autolock_suspend.sh" &
redshift &
confmon.sh
