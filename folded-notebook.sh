#!/bin/bash

xrandr_off() {
  local display=$1
  xrandr --output "$display" --off
}

LID_STATUS=$(cat /proc/acpi/button/lid/LID0/state | awk '{print $2}')

if [[ "$LID_STATUS" == "closed" ]]; then
  NOTEBOOK_DISPLAY=""
  # Had to comment and hardcode eDP-1, otherwise xrandr would reply: `Can't open display eDP-1` {{{
  #while IFS= read -r line; do
  #  if [[ $line =~ ^.*[0-9]+: ]]; then
  #    DISPLAY=$(echo "$line" | awk '{print $4}' | awk '{$1=$1;print}')
  #    if [[ $DISPLAY =~ 'eDP' ]]; then
  #      NOTEBOOK_DISPLAY=$DISPLAY
  #      break
  #    fi
  #  fi
  #done <<< "$(xrandr --listmonitors)"

  NOTEBOOK_DISPLAY='eDP-1'
  # }}}

  if [[ -n "$NOTEBOOK_DISPLAY" ]]; then
    xrandr_off "$NOTEBOOK_DISPLAY"
  fi
fi

