#!/usr/bin/zsh

function usage {
  echo "$(basename $0) -h --> shows usage"
  echo "             -l --> lists themes"
  echo "             -r --> applies random theme"
  echo "             -s theme --> applies specific theme"
}

wallpapers_folder=$HOME/.local/share/wallpapers
wallpapers=$(find $wallpapers_folder -type f)

optstring="lrhs:"

if [ $# -eq 0 ]; then
  usage
  exit
fi
    
current=$(filename $(cat $HOME/.cache/wal/wal))

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
        wallpaper=$(echo $wallpapers | grep -v $current | sort -R | head -n1)
        [[ $wallpaper == $current ]] || break
      done
      ;;
    s)
      if [ -z $1 ]; then
        echo "Bad theme $1"
        exit
      fi

  esac 
done

shift "$(($OPTIND-1))"

xwallpaper --output HDMI-0 --stretch "$wallpaper" --output DVI-D-0 --stretch "$wallpaper"

wal -c
wal -i "$wallpaper"

$HOME/.config/polybar/launch.sh

pywalfox update
