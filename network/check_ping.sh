#!/usr/bin/env bash

ping -c 1 $1 2>1 1>/dev/null && echo "$1 is reachable"

