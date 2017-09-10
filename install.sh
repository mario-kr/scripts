#!/usr/bin/env bash

if [ ! -e ~/bin ]; then
    mkdir ~/bin || {
        echo "~/bin does not exist and could not be created." >&2
        echo "abort" >&2
        exit 1
    }
fi

find ./ -mindepth 1 -name '*.sh' -exec cp '{}' ~/bin/ \;

