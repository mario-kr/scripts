#!/usr/bin/env bash

sleep 5

curfocus=$(herbstclient layout | rg '^.*(0x[a-fA-F0-9]{7}) \[FOCUS\]' -r '$1')

herbstclient -i focus_changed | rg 'focus_changed' | while
    read -r line; do
    if [ "$curfocus" != "0x0" ]; then
        compton-trans -w "$curfocus" -o 50
    fi
    curfocus=$(awk '{print $2}' <<< "$line")
    if [ "$curfocus" != "0x0" ]; then
        compton-trans -w "$curfocus" -o 100
    fi
    echo "$line"
done


