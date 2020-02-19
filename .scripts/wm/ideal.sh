#! /bin/sh

locate ".git" | grep git$ | sed 's/\.git//g' | grep -v '\/\.'
