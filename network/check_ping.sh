#!/usr/bin/env bash

ping -c 1 "$1" 1>/dev/null 2>&1 && echo "$1 is reachable"

