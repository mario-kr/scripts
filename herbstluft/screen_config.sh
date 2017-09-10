#!/usr/bin/bash

screens=(LVDS1 HDMI1 VGA1)
offset=0
string=
x0="x0"

for screen in ${screens[*]} ; do
    if xrandr -q | grep -q "$screen connected"; then
        numbers=($(xrandr --prop | grep $screen | egrep -o '[0-9]{3,4}' | cut -d$'\n' -f-2))
        string="$string${numbers[0]}x${numbers[1]}+$offset+0 "
        xrandr --output $screen --pos $offset$x0
        offset=$(($offset+${numbers[0]}))
    fi
done

herbstclient set_monitors $string

