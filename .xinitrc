#!/bin/sh

# keyboard
setxkbmap -layout us,ru -variant , -option grp:win_space_toggle &

# wallpaper
/home/zero42/.fehbg &

sleep 0.5

# transparency
/home/zero42/.xcompmgr &

# information about system
/home/zero42/.dwm/info.sh &

# startup sound
mpv --no-video --quiet /home/zero42/.dwm/startup.wav &

# start dwm
exec dwm 
