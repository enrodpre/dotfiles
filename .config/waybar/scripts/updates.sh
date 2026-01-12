#!/usr/bin/env bash 

UPDATES=$(paru -Qu | wc -l)
if [ -n $UPDATES ]; then
  echo $UPDATES
else 
  echo "None"
fi
