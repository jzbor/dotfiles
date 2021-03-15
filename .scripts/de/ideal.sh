#! /bin/sh

# Dependencies: locate


locate ".git" | grep git$ | sed 's/\.git//g' | grep -v '\/\.'
