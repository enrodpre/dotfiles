#!/usr/bin/env zsh

NAME_LEFT="HDMI-A-0"
NAME_RIGHT="DisplayPort-2"

OPT=${1:-"--both"}

XRANDR_OPTS=

config_left() {
  if [[ "$1" = "0" ]]; then
    PRIMARY_OPT="--primary "
  else
    PRIMARY_OPT="--left-of $NAME_RIGHT"
  fi

  XRANDR_OPTS="${XRANDR_OPTS}--output ${NAME_LEFT} --mode 2560x1440 --rate 144 ${PRIMARY_OPT}"
}
config_right() {
  if [[ "$1" = "0" ]]; then
    PRIMARY_OPT="--primary"
  else
    PRIMARY_OPT="--right-of $NAME_LEFT"
  fi

  XRANDR_OPTS="${XRANDR_OPTS}--output ${NAME_RIGHT} --mode 1920x1080 ${PRIMARY_OPT}"
}

case "$OPT" in
--both)
  config_left 0
  config_left
  ;;
--left)
  config_left 0
  ;;
--right)
  config_right 0
  ;;
*)
  echo "Usage: $(basename $0) --<both,left,right>"
  exit 1
  ;;
esac

echo "xrandr $XRANDR_OPTS"
