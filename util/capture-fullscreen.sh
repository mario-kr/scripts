#!/usr/bin/env bash

length=${1-3}
delay=${2-0}

#geometry=($(xrectsel "%wx%h %x,%y"))
geometry=(1920x1080 0,0)
output_dir="/home/mario/Videos/captures"

mkdir -p "$output_dir"

sleep "$delay"

ffmpeg -t "$length" -video_size "${geometry[0]}" \
    -f x11grab -i ":0.0+${geometry[1]}" \
    -c:v libx264 -preset ultrafast \
    -pix_fmt yuva444p16be \
    -vf "scale=1920:-2:flags=lanczos+full_chroma_inp+full_chroma_int+accurate_rnd" \
    -flags +global_header -movflags faststart \
    "$output_dir/$(date +"%y_%d_%m_%H_%M_%S").mp4"
