#!/bin/bash

INTERNAL=$(xrandr --query | grep " connected" | grep "eDP" | awk '{print $1}')
[ -z "$INTERNAL" ] && INTERNAL="eDP1"

EXTERNAL=$(xrandr --query | grep " connected" | grep -v "$INTERNAL" | awk '{print $1}')

if [ -n "$EXTERNAL" ]; then
    RES_INT=$(xrandr --query | sed -n "/^$INTERNAL connected/,/^[a-zA-Z]/p" | grep "   " | head -n1 | awk '{print $1}')
    RES_EXT=$(xrandr --query | sed -n "/^$EXTERNAL connected/,/^[a-zA-Z]/p" | grep "   " | head -n1 | awk '{print $1}')

    WIDTH_INT=$(echo "$RES_INT" | cut -d'x' -f1)
    WIDTH_EXT=$(echo "$RES_EXT" | cut -d'x' -f1)

    if [ "$WIDTH_EXT" -lt "$WIDTH_INT" ]; then
        COMMON_RES="$RES_EXT"
    else
        COMMON_RES="$RES_INT"
    fi

    # 4. Aplica a resolução escolhida em AMBOS (removemos o --auto e usamos --mode)
    xrandr --output "$EXTERNAL" --mode "$COMMON_RES" --primary \
           --output "$INTERNAL" --mode "$COMMON_RES" --same-as "$EXTERNAL"

    bspc monitor "$INTERNAL" -d α β γ δ ε ζ η θ ι κ
    bspc query -M | grep -v "$(bspc query -M -m $INTERNAL)" | xargs -I {} bspc monitor {} --remove

else
    xrandr --output "$INTERNAL" --primary --auto

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
