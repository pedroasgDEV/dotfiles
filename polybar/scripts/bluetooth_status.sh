#!/bin/sh

ICON_ON="󰂯"
ICON_OFF="󰂲"

if echo "show" | bluetoothctl | grep -q "Powered: yes"; then
    connected_devices=$(echo "devices Connected" | bluetoothctl | grep "Device" | wc -l)
    
    if [ "$connected_devices" -gt 0 ]; then
        echo "$ICON_ON $connected_devices"
    else
        echo "$ICON_ON"
    fi
else
    echo "$ICON_OFF"
fi
