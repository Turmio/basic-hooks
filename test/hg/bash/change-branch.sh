#!/bin/bash

if [ -z $2 ]; then
   echo "ERROR: Branch name not given. Cannot create branch without name."
   exit 1
fi

CURRENT=$(hg branch)

if [ "$CURRENT" = "$1" ]; then 
    echo "WARN: Already in given branch."
fi

hg -R $1 branch $2
hg -R $1 push -f
