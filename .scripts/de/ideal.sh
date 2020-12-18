#! /bin/sh

# Check dependencies
DEPENDENCIES="locate"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


locate ".git" | grep git$ | sed 's/\.git//g' | grep -v '\/\.'
