#!/bin/bash

if [ "$1" != "" ]; then
  map="$1"
else
  map=$(setxkbmap -query | grep layout | awk '{print $2}')

  if [ "$map" == "cz" ]; then
    map="us"
  else
    map="cz"
  fi
fi

DISPLAY=:0 setxkbmap $map
