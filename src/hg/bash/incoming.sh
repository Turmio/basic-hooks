#!/bin/bash

ON_NEW=$1
ON_EXISTING=$2
ON_CLOSED=$3

REPO=`echo $(echo "$HG_URL" | sed "s/^file://g")`

#get branch
BRANCH=`hg log --rev $HG_NODE --template "{branch}\n"`
#first commit to branch
FIRST=`hg log -r "min(branch($BRANCH))" --template "{node}\n"`
#is closed
CLOSED=`hg log -r "closed() and branch($BRANCH)" --template "{node}\n" | awk 'NR==1'`

if [ "$HG_NODE" = "$FIRST" ]; then
    CMD="$ON_NEW $BRANCH $HG_NODE"
    eval $CMD
elif [ "$HG_NODE" = "$CLOSED" ]; then
    CMD="$ON_CLOSED $BRANCH $HG_NODE"
    eval $CMD
else
    CMD="$ON_EXISTING $BRANCH $HG_NODE"
    eval $CMD
fi
