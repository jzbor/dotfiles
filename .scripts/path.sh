#!/bin/sh

find $(realpath "$(dirname $0)") -maxdepth 1 -type d | grep -v ".git" | tr "\n" ":"
