#!/bin/bash

if [ -z "$1" ]; then
    echo File was not defined
fi

if [ ! -f "$1" ]; then
    touch "$1"
fi

echo $2 $3 >> $1
