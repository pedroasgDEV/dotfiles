#!/bin/sh

if rfkill list bluetooth | grep -q "Soft blocked: yes"; then
    rfkill unblock bluetooth
else
    rfkill block bluetooth
fi