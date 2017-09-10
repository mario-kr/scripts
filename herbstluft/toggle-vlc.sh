#!/usr/bin/env bash

steps=${1-5}

sourcex=1520
targetx=1920

if herbstclient monitor_rect vlc | grep -q 1520; then
    # fade out
    nextstep=$(( sourcex + steps ))
    while [ $nextstep -lt $targetx ]; do
        herbstclient move_monitor vlc 400x300+${nextstep}+780 &
        sleep 0.01
        nextstep=$(( nextstep + steps ))
    done
    herbstclient move_monitor vlc 400x300+${targetx}+780
else
    # fade in
    nextstep=$(( targetx - steps ))
    while [ $nextstep -gt $sourcex ]; do
        herbstclient move_monitor vlc 400x300+${nextstep}+780 &
        sleep 0.01
        nextstep=$(( nextstep - steps ))
    done
    herbstclient move_monitor vlc 400x300+${sourcex}+780
fi

