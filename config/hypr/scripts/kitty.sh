#!/usr/bin/env bash

ACTIVE_PID=$(hyprctl activewindow -j | jq -r '.pid')
CHILD_PID=$(pgrep -P "$ACTIVE_PID" | tail -n 1)

if [ -z "$CHILD_PID" ]; then
    CWD=$HOME
else
    CWD=$(readlink /proc/"$CHILD_PID"/cwd 2>/dev/null || echo $HOME)
fi

kitty --directory "$CWD"
