#!/bin/bash

# Define the temporary image location
TMPBG=/tmp/screen.png

# Take a screenshot
scrot -o "$TMPBG"

# Apply the blur effect
convert "$TMPBG" -scale 10% -blur 0x2.5 -resize 1000% "$TMPBG"

# Lock the screen with the blurred image and Gruvbox colors
i3lock \
    --insidever-color=32302f00 \
    --insidewrong-color=32302f00 \
    --inside-color=32302f00 \
    --ringver-color=83a598ff \
    --ringwrong-color=fb4934ff \
    --ring-color=fabd2fff \
    --line-uses-inside \
    --keyhl-color=b8bb26ff \
    --bshl-color=928374ff \
    --separator-color=00000000 \
    --verif-color=ebdbb2ff \
    --wrong-color=ebdbb2ff \
    --time-color=ebdbb2ff \
    --date-color=ebdbb2ff \
    --layout-color=ebdbb2ff \
    --screen 1 \
    --blur 5 \
    --clock \
    --indicator \
    --time-str="%H:%M:%S" \
    --verif-text="Verifying..." \
    --wrong-text="Access Denied" \
    --noinput-text="Empty" \
    -i "$TMPBG"

# Remove the temporary image upon unlocking
rm "$TMPBG"