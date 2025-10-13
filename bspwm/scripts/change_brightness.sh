#!/bin/bash

STEP=5

if [ "$1" = "up" ]; then
    brightnessctl set "+$STEP%"
    operator="+"
elif [ "$1" = "down" ]; then
    brightnessctl set "$STEP%-"
    operator="-"
else
    echo "Uso: $0 <up|down>"
    exit 1
fi

for monitor in $(xrandr --query | grep " connected" | cut -d' ' -f1); do
    current_brightness=$(xrandr --verbose | grep -A5 "$monitor" | grep 'Brightness:' | cut -d ' ' -f2)

    step_decimal=$(echo "$STEP / 100" | bc -l)
    new_brightness=$(echo "$current_brightness $operator $step_decimal" | bc)

    if (( $(echo "$new_brightness > 1.0" | bc -l) )); then
        new_brightness=1.0
    elif (( $(echo "$new_brightness < 0.0" | bc -l) )); then
        new_brightness=0.0
    fi

    xrandr --output "$monitor" --brightness "$new_brightness"
done