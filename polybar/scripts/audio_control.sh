#!/bin/sh

get_audio_status() {
    SINK_MUTED=$(pamixer --get-mute)
    if [ "$SINK_MUTED" = "true" ]; then
        SINK_ICON=""
        SINK_VOLUME="Muted"
    else
        SINK_ICON="" 
        SINK_VOLUME=$(pamixer --get-volume-human)
    fi

    SOURCE_MUTED=$(pamixer --default-source --get-mute)
    if [ "$SOURCE_MUTED" = "true" ]; then
        SOURCE_ICON="" 
        SOURCE_VOLUME="Muted"
    else
        SOURCE_ICON="" 
        SOURCE_VOLUME=$(pamixer --default-source --get-volume-human)
    fi

    echo "$SINK_ICON $SINK_VOLUME  $SOURCE_ICON$SOURCE_VOLUME"
}

get_audio_status

pactl subscribe | while read -r event; do
    if echo "$event" | grep -q "sink" || echo "$event" | grep -q "source"; then
        get_audio_status
    fi
done