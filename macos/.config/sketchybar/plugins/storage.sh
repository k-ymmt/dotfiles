#!/usr/bin/env bash

used=$(df / | awk 'END{print $5}' | tr -d '%' | awk '{print 100-$1}')

case "$used" in
  [9][0-9]) 
    color=0xeecc241d 
    icon="􁘨"
    ;;
  * ) 
    color=0xeeebdbb2
    icon="􀤃"
esac

sketchybar --set "$NAME" label.color=$color label="$used%" icon="$icon" icon.color="$color"

