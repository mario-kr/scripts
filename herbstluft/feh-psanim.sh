#!/usr/bin/env bash

while true; do
    for arg; do
        feh --bg-fill --geometry 1920x1080+0+0 --no-fehbg $arg
        sleep 0.02
    done
done

