#!/bin/sh

ICON_DISCONNECTED="󰤮"
output=""

for iface in $(ls /sys/class/net); do
    if [ -d "/sys/class/net/$iface/wireless" ] && \
       (ip link show "$iface" | grep -q "state UP") && \
       (ip addr show "$iface" | grep -q "inet"); then
        
        IP_ADDRESS=$(ip addr show "$iface" | grep "inet " | awk '{print $2}' | cut -d'/' -f1)
        output="$output $iface:$IP_ADDRESS"
    fi
done

if [ -z "$output" ]; then
    echo "$ICON_DISCONNECTED"
else
    echo "${output# }"
fi