#!/bin/sh

rofi -show run -theme config\
    -terminal terminator -ssh-command '{terminal} -e "{ssh-client} {host}"' \
    $@
