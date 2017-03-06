#!/bin/sh

if [ -z "$1" ]; then
    echo "Cannot close branch because repository is not defined"
    exit 1
fi

hg commit -R $1 --config ui.username=test --close-branch -m "closed"
hg push -R $1