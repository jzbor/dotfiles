#!/bin/sh
# Check dependencies
DEPENDENCIES="pstree"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


kill "$(pstree -lp | grep -- -dwmstatus\.sh | sed 's/.*sleep(//;s/).*//' | head -n 1)" 2> /dev/null
