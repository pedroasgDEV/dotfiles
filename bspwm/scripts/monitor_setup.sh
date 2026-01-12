#!/bin/bash

INTERNAL=$(xrandr --query | grep " connected" | grep "eDP" | awk '{print $1}')
[ -z "$INTERNAL" ] && INTERNAL="eDP1"

EXTERNAL=$(xrandr --query | grep " connected" | grep -v "$INTERNAL" | awk '{print $1}')

if [ -n "$EXTERNAL" ]; then
    xrandr --output "$INTERNAL" --primary --auto --brightness 1.0 --gamma 1.0 \
           --output "$EXTERNAL" --auto --brightness 1.0 --gamma 1.0 --above "$INTERNAL"

    bspc monitor "$INTERNAL" -d α β γ δ ε
    bspc monitor "$EXTERNAL" -d Α Β Γ Δ Ε

    bspc wm -O "$INTERNAL" "$EXTERNAL"
else
    xrandr --output "$INTERNAL" --primary --auto --brightness 1.0 --gamma 1.0

    for monitor in $(xrandr --query | grep " disconnected" | awk '{print $1}'); do
        xrandr --output "$monitor" --off
    done

    bspc monitor "$INTERNAL" -d α β γ δ ε ζ η θ ι κ
    bspc query -M | grep -v "$(bspc query -M -m $INTERNAL)" | xargs -I {} bspc monitor {} --remove
fi

feh --bg-scale "$HOME/Pictures/wallpapers/medalha.png" --image-bg "#23262d"

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
$HOME/.config/polybar/scripts/launcher.sh &
