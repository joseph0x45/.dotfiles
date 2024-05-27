#!/bin/bash

# Check if the HDMI-2 display is connected
if xrandr | grep -q "HDMI-2 connected"; then
    # HDMI-2 is connected, revert xrandr configuration
    xrandr --output eDP-1 --auto --output HDMI-2 --off
fi

