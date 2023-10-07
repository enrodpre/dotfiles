#!/usr/bin/zsh

local savedir="$HOME/images"

if [ ! -d "$savedir" ] 
then
  mkdir "$savedir"
fi

local save_filepath="$savedir/$(find $savedir -type f -printf '%f\n' | rofi -dmenu)"

maim -s "$save_filepath"

notify "Saved image to $save_filepath"
