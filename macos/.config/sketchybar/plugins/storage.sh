#!/usr/bin/env bash

used=$(diskutil info / | awk -F: '
function trim(s){ sub(/^[ \\t]+/, "", s); sub(/[ \\t]+$/, "", s); return s }

function bytes_in_parens(s,    t, a){
    t = trim(s)
    split(t, a, "(")
    if (length(a) < 2) return -1
    sub(/[[:space:]]*[Bb]ytes?.*$/, "", a[2])
    gsub(/[^0-9]/, "", a[2])
    if (a[2] == "") return -1
    return a[2] + 0
}

BEGIN { total=-1; free=-1 }

$1 ~ /^[ \\t]*Container Total Space$/ { total = bytes_in_parens($2) }
$1 ~ /^[ \\t]*Container Free Space$/  { free  = bytes_in_parens($2) }

END {
    if (total <= 0 || free < 0) exit 2
    used = total - free
    if (used < 0) used = 0
    pct = int((used * 100) / total + 0.5)   # round to nearest integer
    printf "%d\n", pct
}
')

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

