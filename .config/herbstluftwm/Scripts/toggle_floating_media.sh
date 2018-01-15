#!/usr/bin/sh

hc() { "${herbstclient_command[@]:-herbstclient}" "$@" ;}
monitors=$(herbstclient get_attr monitors.count)
tag="hc get_attr tags.focus.index"

if [ "$monitors" -gt 1 ]; then
    hc focus_monitor 1
    hc fullscreen off
    hc remove_monitor 1
    hc merge_tag media
    hc use_index $tag
else
    hc add_monitor 590x332+1330+748
    hc add media
    hc move_index 9
    hc focus_monitor 1
    hc use_index 9
    hc fullscreen on
    hc focus_monitor 0
    hc use_index $tag
fi
