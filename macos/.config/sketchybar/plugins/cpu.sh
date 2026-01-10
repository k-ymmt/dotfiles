#!/usr/bin/env bash

CPU=$(top -l 1 -n 0 | grep "CPU usage" | sed -E 's/.*idle ([0-9.]+)%/\1/' | awk '{printf "%d\n", 100 - $7 + 0.5}')
sketchybar --set "$NAME" label="$CPU%"
