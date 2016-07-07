#!/bin/sh
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Activate Numlock
numlockx

# Set keyboard layout
setxkbmap se

# URxvt daemon
urxvtd -q -f -o &

# Start the WM
exec i3
