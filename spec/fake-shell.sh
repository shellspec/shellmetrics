#!/bin/sh
[ "$1" = "-c" ] && eval "$2" && exit 0
echo "fake-shell"
