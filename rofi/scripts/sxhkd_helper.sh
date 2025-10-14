#!/bin/bash

SXHKDRC_PATH="$HOME/.config/sxhkd/sxhkdrc"

awk '
# Rule: If the current line starts with "# "
/^# / {
    # Store the title, removing the "# "
    title = substr($0, 3);

    # Get the next line from the file
    getline nextline;

    # If the next line starts with "super"
    if (nextline ~ /^super/) {
        # Print "Title: Shortcut"
        printf "<b>%s: </b><i>%s</i>\0", title, nextline;
    }
}
' "$SXHKDRC_PATH"