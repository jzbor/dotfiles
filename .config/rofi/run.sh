#!/bin/sh

rofi -show run \
    -terminal terminator -ssh-command '{terminal} -e "{ssh-client} {host}"' \
    $@
