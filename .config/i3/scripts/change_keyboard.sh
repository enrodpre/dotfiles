#!/bin/bash

current_layout=$(setxkbmap -query | grep layout | egrep -o "(es|us)")

if [ $current_layout == "es" ];
then
  setxkbmap -layout us -option ctrl:nocaps
else
  setxkbmap -layout es -option ctrl:nocaps
fi
