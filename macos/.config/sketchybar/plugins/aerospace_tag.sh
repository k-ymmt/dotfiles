#!/usr/bin/env bash

set -u

export PATH="$HOME/bin:/opt/homebrew/bin:/usr/local/bin:$HOME/.local/bin:$PATH"

COLOR_SEL_BG="0xddfe8019"
COLOR_SEL_FG="0xfe282828"
COLOR_OCC_BG="0xdd504945"
COLOR_OCC_FG="0xfeebdbb2"
COLOR_EMPTY_BG="0x00000000"
COLOR_EMPTY_FG="0x88665c54"

log() {
  echo "[tagaero.sh] $*" >&2
}

is_uint() {
  [[ "$1" =~ ^[0-9]+$ ]]
}

if ! command -v sketchybar >/dev/null 2>&1; then
  log "sketchybar command not found in PATH"
  exit 0
fi

if [[ -z "${NAME:-}" ]]; then
  log "missing NAME"
  exit 0
fi

if [[ "$NAME" != tagaero.tag.* ]]; then
  log "unexpected item name: $NAME"
  exit 0
fi

tag_index="${NAME##*.}"
if ! is_uint "$tag_index" || (( tag_index < 1 || tag_index > 10 )); then
  log "invalid tag index: $tag_index"
  exit 0
fi

selected_tags="${FOCUSED_TAGS:-${AEROSPACE_FOCUSED_TAGS:-${SELECTED_TAGS:-}}}"
monitor_id="${MONITOR_ID:-${AEROSPACE_MONITOR_ID:-}}"
display_id="${DISPLAY:-}"
occupied_tags="${OCCUPIED_TAGS:-${AEROSPACE_OCCUPIED_TAGS:-}}"

if [[ -z "$selected_tags" ]]; then
  log "missing selected tags (FOCUSED_TAGS/AEROSPACE_FOCUSED_TAGS/SELECTED_TAGS)"
  exit 0
fi

if ! is_uint "$selected_tags"; then
  log "selected tags must be unsigned integer: $selected_tags"
  exit 0
fi

if [[ -n "$monitor_id" ]] && ! is_uint "$monitor_id"; then
  log "monitor id must be unsigned integer: $monitor_id"
  exit 0
fi

if [[ -z "$occupied_tags" ]] && [[ -n "$monitor_id" ]] && command -v aerospace >/dev/null 2>&1; then
  occupied_tags="$(aerospace list-workspaces --monitor "$monitor_id" --visible --format '%{monitor-occupied-tags}' 2>/dev/null | head -n 1 | tr -d '\r')"
fi

if [[ -z "$display_id" ]] && [[ -n "$monitor_id" ]] && command -v aerospace >/dev/null 2>&1; then
  display_id="$(aerospace list-workspaces --monitor "$monitor_id" --visible --format '%{monitor-appkit-nsscreen-screens-id}' 2>/dev/null | head -n 1 | tr -d '\r')"
fi

# Fallback to monitor-id if monitor-appkit mapping isn't available
if [[ -z "$display_id" ]] && [[ -n "$monitor_id" ]]; then
  display_id="$monitor_id"
fi

# If occupied tags are unavailable, treat non-selected tags as empty.
if ! is_uint "${occupied_tags:-}"; then
  occupied_tags="$selected_tags"
fi

bit=$((1 << (tag_index - 1)))

if (( selected_tags & bit )); then
  bg="$COLOR_SEL_BG"
  fg="$COLOR_SEL_FG"
elif (( occupied_tags & bit )); then
  bg="$COLOR_OCC_BG"
  fg="$COLOR_OCC_FG"
else
  bg="$COLOR_EMPTY_BG"
  fg="$COLOR_EMPTY_FG"
fi

args=(
  --set "$NAME"
  background.color="$bg"
  label.color="$fg"
)

if is_uint "${display_id:-}"; then
  args+=(display="$display_id")
fi

sketchybar "${args[@]}"
