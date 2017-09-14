#!/usr/bin/env bash

pgrep vlc && exit 1

herbstclient add vlc
herbstclient add_monitor 400x300+1520+780 vlc vlc

vlc "$@" 2>/dev/null &
sleep 1

herbstclient move vlc

herbstclient focus_monitor vlc
herbstclient use vlc
herbstclient focus_monitor 0

herbstclient keybind Mod4-m spawn ~/bin/toggle-vlc.sh

~/bin/toggle-vlc.sh

