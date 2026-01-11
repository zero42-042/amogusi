#!/bin/sh

# keyboard
setxkbmap -layout us,ru -variant , -option grp:win_space_toggle &

# wallpaper
~/.fehbg &

sleep 0.1

# transparency
~/.xcompmgr &

# information about system
~/.dwm/info.sh &

# startup sound
mpv --no-video --quiet ~/.dwm/startup.wav &

# start dwm
exec dwm 
