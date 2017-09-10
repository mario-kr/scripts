#!/usr/bin/env bash

echo

i=0
while [ $i -lt 256 ]; do
    ~/bin/check_ping.sh "$1.$i" &
    let i=$i+1
done

sleep 5
