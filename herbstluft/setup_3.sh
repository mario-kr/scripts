#!/usr/bin/env bash

if [ $# -ne 1 ]; then
    exit 1
fi

screen=$1
scrn=$((screen +1))

fsplitv.sh "${screen}:$screen" 3:1
fsplith.sh "${scrn}:$scrn" 2:1
fsplith.sh "${scrn}:$scrn" 1:1

