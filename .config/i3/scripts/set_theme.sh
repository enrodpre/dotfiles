#!/usr/bin/zsh

function usage {
  echo "$(basename $0) -h --> shows usage"
  echo "             -l --> lists themes"
  echo "             -r --> applies random theme"
  echo "             -s theme --> applies specific theme"
}

wallpapers_folder=$HOME/.config/wallpapers
wallpapers=$(find $wallpapers_folder -type f | while read line; do filename $line; done)

optstring="lrhs:"

if [ $# -eq 0 ]; then
  usage
  exit
fi
    
while getopts ${optstring} arg; do
  case ${arg} in
    h)
      usage
      exit
      ;;
    l)
      while read line; do echo $line; done <<< "$wallpapers"
      exit
      ;;
    r)
      while true; do
        THEME=$(echo $wallpapers | sort -R | head -n1)
        current=$(filename $(cat $HOME/.cache/wal/wal))
        [[ $THEME == $current ]] || break
      done
      ;;
    s)
      if [ -z $1 ]; then
        echo "Bad theme $1"
        exit
      fi

      THEME=$OPTARG
  esac 
done

shift "$(($OPTIND-1))"

export THEME


wallpaper=$(find $wallpapers_folder -type f -name "$THEME.*")

xwallpaper --output HDMI-0 --stretch "$wallpaper" --output DVI-D-0 --stretch "$wallpaper"

wal -i "$wallpaper"

$HOME/.config/polybar/polybar.sh

pywalfox update
