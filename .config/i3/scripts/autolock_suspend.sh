#!/bin/bash

TESTING=true

SUSPENDER="systemctl suspend"

get_active_id() {
  xprop -root | awk '$1 ~ /_NET_ACTIVE_WINDOW/ { print $5 }'
}

get_window_title() {
  xprop -id "$1" | awk -F '=' '$1 ~ /_NET_WM_NAME\(UTF8_STRING\)/ { print $2 }'
}

is_fullscreen() {
  xprop -id "$1" | awk -F '=' '$1 ~ /_NET_WM_STATE\(ATOM\)/ { for (i=2; i<=3; i++) if ($i ~ /FULLSCREEN/) exit 0; exit 1 }'
  return $?
}

is_playing() {
  pacmd list-sink-inputs | grep -c "state: RUNNING"
}

should_lock() {
  id=$(get_active_id)
  title="$(get_window_title "$id")"
    
  if is_playing ; then
    return 0
  else
    return 1
  fi
}

if should_lock; then
  if TESTING; then
    echo 'SUSPENDER'
  else
    eval "$SUSPENDER"
  fi
fi
