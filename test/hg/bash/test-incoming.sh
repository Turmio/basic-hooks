#!/bin/bash

checkReturnCode() {
    if [ $1 -eq 1 ]; then
        eval $2
        exit 1
    fi
}

REPO1=repository1
REPO2=repository2
SCRIPT_PATH=$(dirname `which $0`)
ABSOLUTE=$(cd $SCRIPT_PATH; pwd)
CLEANUP="source $SCRIPT_PATH/clean-repos.sh $REPO1 $REPO2"

source $ABSOLUTE/init-repos.sh $REPO1 $REPO2
ret_code=$?
checkReturnCode $ret_code $CLEANUP

WRITE_RESULTS=$ABSOLUTE/write-file.sh
NEWBRANCH=$ABSOLUTE/newbranch
EXISTING=$ABSOLUTE/existing
CLOSED=$ABSOLUTE/closed

NP="$WRITE_RESULTS $NEWBRANCH"
NE="$WRITE_RESULTS $EXISTING"
NC="$WRITE_RESULTS $CLOSED"
source $SCRIPT_PATH/add-hook.sh $REPO1 incoming "$NP"  "$NE" "$NC"
ret_code=$? 
checkReturnCode $ret_code $CLEANUP


source $SCRIPT_PATH/change-file.sh $ABSOLUTE/$REPO2 "file"
ret_code=$? 
checkReturnCode $ret_code $CLEANUP

source $SCRIPT_PATH/change-file.sh $ABSOLUTE/$REPO2 "file"
ret_code=$? 
checkReturnCode $ret_code $CLEANUP

source $SCRIPT_PATH/close-branch.sh $ABSOLUTE/$REPO2
ret_code=$? 
checkReturnCode $ret_code $CLEANUP

eval $CLEANUP