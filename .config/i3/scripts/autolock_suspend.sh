#!/bin/bash

TESTING=false

SUSPENDER="systemctl suspend"

no_sound() {
  if pactl list sinks | grep -c "state: RUNNING"
  then
    return 0
  else 
    return 1
  fi
}

if no_sound; then
  if $TESTING; then
    echo 'SUSPENDER'
  else
    eval "$SUSPENDER"
  fi
fi
