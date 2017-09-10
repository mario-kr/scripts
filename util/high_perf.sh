#!/bin/bash

xbacklight -set 100
cpupower set -b 6
#cpupower frequency-set -u 3200000
cpupower frequency-set -g performance
