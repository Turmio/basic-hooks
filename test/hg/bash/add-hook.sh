#!/bin/bash

if [ -z "$1" ]; then
    echo "Cannot add hook because repository is not defined"
    exit 1
fi

if [ -z "$2" ]; then
    echo "Cannot add hook because hook is not defined"
    exit 1
fi


SCRIPT_PATH=$(dirname `which $0`)
REPO=$1

HGRC="$SCRIPT_PATH/$REPO/.hg/hgrc"
CURRENT=`pwd`
ABSOLUTE=$(cd $SCRIPT_PATH; pwd)
HOOKPATH=$(cd $ABSOLUTE/../../../src/hg/bash; pwd)
HOOK=$HOOKPATH/$2.sh

cd $CURRENT

if [ ! -f $HGRC ]; then
    touch $HGRC
fi

echo "">> $HGRC
echo "[hooks]">> $HGRC
echo "$2 = $HOOK \"$3\" \"$4\" \"$5\"">> $HGRC