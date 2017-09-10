#!/usr/bin/env bash

if [ $# -ne 1 ]; then
    exit 1
fi

screen=$1
scrn=$((screen +1))

fsplitv.sh "${screen}:$screen" 7:1
fsplith.sh "${scrn}:$scrn" 5:1
fsplith.sh "${scrn}:$scrn" 4:1
fsplith.sh "${scrn}:$scrn" 3:1
fsplith.sh "${scrn}:$scrn" 2:1
fsplith.sh "${scrn}:$scrn" 1:1

