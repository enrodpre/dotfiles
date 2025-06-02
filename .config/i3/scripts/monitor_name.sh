#!/usr/bin/env zsh

NROW=

case "$1" in
--left)
  NROW=2
  ;;
--right)
  NROW=3
  ;;
*)
  echo "Usage: $(basename $0) --<left,right>"
  exit 1
  ;;
esac

xrandr --listactivemonitors | sed -n "${NROW}p" | cut -d ' ' -f 6
