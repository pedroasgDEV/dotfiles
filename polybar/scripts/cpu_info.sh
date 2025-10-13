#!/bin/sh

CPU_CORES_USAGE=$(LC_ALL=C mpstat -P ALL | awk 'NR > 4 {printf "Core %s: %.2f%%\n", $2, 100 - $NF}')
MESSAGE="$CPU_CORES_USAGE"
notify-send "CPU" "$MESSAGE" -u normal