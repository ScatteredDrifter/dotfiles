#!/usr/bin/sh

hc() { "${herbstclient_command[@]:-herbstclient}" "$@" ;}
monitors=$(herbstclient get_attr monitors.count)

if [ "$monitors" -gt 1 ]; then
    hc remove_monitor 1
    hc set_monitors 1920x1080+0 
else
    hc set_monitors 1280x1080+0 643x1067+1280+15 
    hc focus_monitor 1
    hc use_index 8
fi
