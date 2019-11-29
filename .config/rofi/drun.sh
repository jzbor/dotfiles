#!/bin/sh

rofi -show drun
    -terminal terminator -ssh-command '{terminal} -e "{ssh-client} {host}"' \
    $@
