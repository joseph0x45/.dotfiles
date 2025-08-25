#!/usr/bin/env sh
$monitor = $1
xrandr --output HDMI-$monitor --mode 1920x1080 --rate 180
