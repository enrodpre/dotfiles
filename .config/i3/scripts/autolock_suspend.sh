#!/bin/bash

TESTING=false

SUSPENDER="systemctl suspend"

no_sound() {
  if pactl list sinks | grep -c "State: RUNNING"
  then
    return 1
  else 
    return 0
  fi
}

if no_sound; then
  if $TESTING; then
    echo 'SUSPENDER'
  else
    eval "$SUSPENDER"
  fi
fi
