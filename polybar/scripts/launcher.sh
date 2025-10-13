#!/bin/bash

# Terminate already running bar instances
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch a bar for each connected monitor
if type "xrandr"; then
  for m in $(polybar -m | cut -d':' -f1); do
    MONITOR=$m polybar --reload example &
  done
else
  polybar --reload example &
fi
