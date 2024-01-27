#!/usr/bin/env bash

dir="$HOME/.config/polybar"
themes=(`ls --hide="launch.sh" $dir`)

launch_bar() {
	# Terminate already running bar instances
	killall -q polybar

	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

	# Launch the bar
  polybar -q main -c "$dir/config.ini" &	
}

launch_bar >> $HOME/logs/polybar.log

# $HOME/.config/polybar/scripts/pywal.sh "$(cat $HOME/.cache/wal/wal)"
