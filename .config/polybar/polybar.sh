#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch polybar
polybar left & 2>> ~/log
sleep 0.5
polybar center & 2>> ~/log
sleep 0.5
polybar right & 2>> ~/log
