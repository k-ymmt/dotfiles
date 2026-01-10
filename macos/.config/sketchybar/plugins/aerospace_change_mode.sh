#!/usr/bin/env bash

case "$(aerospace list-modes --current)" in
  "main" ) color=0xeeb8bb26 ;;
  "aerospace" ) color=0xeefe8019 ;;
  "service" ) color=0xeefabd2f ;;
  "resize" ) color=0xee8ec07c ;;
esac

sketchybar --bar border_color=$color
