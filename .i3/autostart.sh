#!/bin/bash

# mouse settings
xset m 0/0

# Configure monitors
xrandr --dpi 96 --output DVI-I-1 --primary --output DVI-D-0 --left-of DVI-I-1 --output HDMI-0 --right-of DVI-I-1

# Hide mouse
unclutter &

# Sound
pulseaudio &

# Names day
sh $HOME/Scripts/bin/namnsdag

# Daylight
sh $HOME/Scripts/bin/daylight

# Notifications
dunst &
twitchnotifier -c ebupof &
mailnag &

# Wallpaper
sh ~/.fehbg &
#xsetroot -solid '#001E26'

# Set Ranger as default file manager
xdg-mime default ranger.desktop inode/directory

# Reload URxvt
xrdb -merge ~/.Xresources
