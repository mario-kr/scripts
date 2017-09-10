#!/bin/bash

if [ $# -lt 1 ]; then
    echo "usage:"
    echo "$0 <start_monitor>:<end_monitor> [ratio]"
    echo "This script splits all monitors in the range (including) start_monitor to"
    echo "end_monitor, indices according to 'herbstclient list_monitors'"
    echo "ratio should be given with e.g. 2:1 or 1:3."
    echo "Example:"
    echo "$0 0:0 3:1"
    echo 'Resulting split of monitor 0:
+------------+------+
|            |      |
|            |      |
|            |      |
|            |      |
|            |      |
+------------+------+'
    exit 0
fi

l=$1
limits=(${l//:/ })

ratio=( 1 1 )
divid=2
if [ $# -eq 2 ]; then
    r=$2
    ratio=(${r//:/ })
    divid=$(( ratio[0] + ratio[1] ))
    echo $divid
fi

hcmon=

# example match of the regex: '0: 1920x1080+0+0'
regex="^([0-9]+): ([1-9][0-9]+)x([1-9][0-9]+)\+([0-9]+)\+([0-9]+).*"

while read -r line; do
    if [[ "$line" =~ $regex ]]; then
        index=${BASH_REMATCH[1]}
        width=${BASH_REMATCH[2]}
        height=${BASH_REMATCH[3]}
        posx1=${BASH_REMATCH[4]}
        posy=${BASH_REMATCH[5]}
        # only split selected indices
        if [ "$index" -ge "${limits[0]}" ] && [ "$index" -le "${limits[1]}" ]; then
            # calculate widths of the new left/right monitors
            nwidth_l=$(((width * ratio[0])/ divid))
            nwidth_r=$(((width * ratio[1])/ divid))
            posx2=$((posx1 + nwidth_l))
            hcmon="$hcmon ${nwidth_l}x${height}+${posx1}+${posy} ${nwidth_r}x${height}+${posx2}+${posy}"
        else
            hcmon="$hcmon ${width}x${height}+${posx1}+${posy}"
        fi
    else
        echo "invalid monitor-specifying string" 1>&2
    fi
done <<< "$(herbstclient list_monitors)"

# Note: word splitting of $hcmon is required here
herbstclient set_monitors $hcmon

