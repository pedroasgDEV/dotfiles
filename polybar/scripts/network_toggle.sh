#!/bin/sh

if [ "$(nmcli networking)" = "enabled" ]; then
    nmcli networking off
else
    nmcli networking on
fi