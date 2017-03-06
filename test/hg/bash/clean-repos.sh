#!/bin/bash
SCRIPT_PATH=$(dirname `which $0`)
echo "Cleaning repositories"
if [ ! -z "$1" ]; then
    rm -r $SCRIPT_PATH/$1
else
    echo "Initial repository name was not defined"
fi

if [ ! -z "$2" ]; then
    rm -r $SCRIPT_PATH/$2
else
    echo "Clone repository name was not defined"
fi

