#!/bin/sh

kill "$(pstree -lp | grep -- -dwmstatus\.sh | sed 's/.*sleep(//;s/).*//' | head -n 1)" 2> /dev/null
