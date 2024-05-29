#!/bin/bash

# Get the status of the displays
MAIN_DISPLAY="eDP-1"
HDMI_DISPLAY="HDMI-2"

# Check if HDMI-2 is connected
if xrandr | grep -q "$HDMI_DISPLAY connected"; then
    # Check if the HDMI display is currently on
    if xrandr | grep -q "$HDMI_DISPLAY connected [^(]*primary"; then
        # HDMI display is currently primary, switch to main display
        xrandr --output $MAIN_DISPLAY --auto --primary --output $HDMI_DISPLAY --off
    else
        # Main display is currently primary, switch to HDMI display
        xrandr --output $MAIN_DISPLAY --off --output $HDMI_DISPLAY --auto --primary
    fi
else
    echo "HDMI display is not connected."
fi
