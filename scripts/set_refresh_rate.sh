#!/usr/bin/env bash

# Usage: ./set_refresh_rate.sh 2
# This will run: xrandr --output HDMI-2 --mode 1920x1080 --rate 180

MONITOR_NUM=$1

if [ -z "$MONITOR_NUM" ]; then
    echo "Usage: $0 <monitor_number>"
    exit 1
fi

xrandr --output "HDMI-$MONITOR_NUM" --mode 1920x1080 --rate 180

