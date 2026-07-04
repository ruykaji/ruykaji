#!/usr/bin/env bash

TERMINAL=$1
BROWSER=$2

LEFT_MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.x == 0) | .name')
LEFT_MONITOR_WIDTH=$(hyprctl monitors -j | jq -r '.[] | select(.x == 0) | .width')

RIGHT_MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.x != 0) | .name')
RIGHT_MONITOR_WIDTH=$(hyprctl monitors -j | jq -r '.[] | select(.x != 0) | .width')

if [ -n "$LEFT_MONITOR" ] && [ -n "$RIGHT_MONITOR" ]; then
  
  if [ "$LEFT_MONITOR_WIDTH" == "2560" ]; then
     hyprctl keyword monitor "$LEFT_MONITOR, 2560x1440@60, 0x0, 1.25"
  else
     hyprctl keyword monitor "$LEFT_MONITOR, prefered, 0x0, 1"
  fi

  if [ "$RIGHT_MONITOR_WIDTH" == "2560" ]; then
     hyprctl keyword monitor "$RIGHT_MONITOR, 2560x1440@60, auto, 1.25"
  else
     hyprctl keyword monitor "$RIGHT_MONITOR, prefered, auto, 1"
  fi

  MAIN_WS="1"
  TERMINAL_WS="2"
  BROWSER_WS="3"

  # Setting workspaces
  hyprctl dispatch moveworkspacetomonitor "$MAIN_WS $RIGHT_MONITOR"

  hyprctl dispatch workspace "$TERMINAL_WS"
  hyprctl dispatch moveworkspacetomonitor "$TERMINAL_WS $LEFT_MONITOR"

  hyprctl dispatch workspace "$BROWSER_WS"
  hyprctl dispatch moveworkspacetomonitor "$BROWSER_WS $LEFT_MONITOR"

  # Setting terminals
  hyprctl dispatch -- exec "[workspace $TERMINAL_WS] $TERMINAL --hold btop" && sleep 0.3

  # BEGIN FASTFETCH
  SOCKET="/tmp/kitty_fetch"
  
  rm -f "$SOCKET"

  hyprctl dispatch -- exec "[workspace $TERMINAL_WS] $TERMINAL --class fastfetch_terminal --listen-on \"unix:$SOCKET\"" && sleep 0.3

  while [ ! -S "$SOCKET" ]; do
    sleep 0.1
  done

  hyprctl dispatch resizewindowpixel "exact 55% 100%,class:^(fastfetch_terminal)$" && sleep 0.3
  kitty @ --to "unix:$SOCKET" send-text "fastfetch\\r"
  # END FASTFETCH

  hyprctl dispatch -- exec "[workspace $TERMINAL_WS] $TERMINAL --hold pipes.sh -c 167 -c 142 -c 214 -c 109 -c 175 -c 108 -c 208"
 
  # Setting browser 
  hyprctl dispatch -- exec "[workspace $BROWSER_WS silent] $BROWSER"

fi

