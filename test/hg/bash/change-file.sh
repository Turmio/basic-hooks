#!/bin/sh
if [ -z "$1" ]; then
    echo "Cannot commit change to branch because repository is not defined"
    exit 1
fi

if [ -z "$2" ]; then
    echo "Cannot commit change to branch because file is not defined"
    exit 1
fi

if [ ! -f "$1/$2" ]; then
    touch $1/$2
fi

echo "text" >> $1/$2
hg add -R $1 $1/*
hg commit -R $1 --config ui.username=test -m "changed file from $0"
hg push -R $1