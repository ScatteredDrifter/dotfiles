#!/bin/bash

# mouse settings
xset m 0/0 &

# Keyboard layout
setxkbmap se &

# Disable NumLock
numlockx &

# Configure monitors
xrandr --dpi 96 --output DVI-I-1 --primary --output DVI-D-0 --left-of DVI-I-1 --output HMDI-0 --right-of DVI-I-1 &

# URxvt daemon
urxvtd -q -f -o &

# Desktop notifications
dunst &

# Hide mouse
unclutter &

# Names day
sh $HOME/.bin/namnsdag &

# Twitch notifications
twitchnotifier -c ebupof &

# Restore wallpaper
sh ~/.fehbg &

# Set Ranger as default file manager
xdg-mime default ranger.desktop inode/directory &
