#!/usr/bin/env zsh

TESTING=${1:-false}

if [ "$TESTING" = true ]; then
    SUSPENDER="echo suspender"
else
    SUSPENDER="systemctl suspend"
fi

no_sound() {
    sound=$(pactl list sinks | grep -c "State: RUNNING")
    return "$sound"
}

if no_sound; then
    eval "$SUSPENDER"
    exit 1
else
    echo NO SUSPENDER
    exit 0
fi
