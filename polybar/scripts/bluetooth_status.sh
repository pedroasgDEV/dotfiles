#!/bin/sh

ICON_ON="󰂯"
ICON_OFF="󰂲"

if bluetoothctl show | grep -q "Powered: yes"; then
    connected_devices=$(bluetoothctl devices Connected | wc -l)
    echo "$ICON_ON $connected_devices"
else
    echo "$ICON_OFF"
fi