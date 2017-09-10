#!/bin/bash

xbacklight -set 5
cpupower set -b 14
#cpupower frequency-set -u 1500000
cpupower frequency-set -g powersave
