#!/bin/bash
if [ -z "$1" ]; then
    echo "Initial repository name was not defined"
    exit 1
fi

if [ -z "$2" ]; then
    echo "Clone repository name was not defined"
    exit 1
fi

SCRIPT_PATH=$(dirname `which $0`)

hg init $SCRIPT_PATH/$1
hg clone $SCRIPT_PATH/$1 $SCRIPT_PATH/$2
 