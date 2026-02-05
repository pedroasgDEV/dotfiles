#!/bin/sh

sxhkd &
exec dbus-launch --exit-with-session bspwm
