#!/bin/bash

checkReturnCode() {
    if [ $1 -eq 1 ]; then
        eval $2
        echo "FAILURE"
        exit 1
    fi
}

REPO1=repository1
REPO2=repository2
SCRIPT_PATH=$(dirname `which $0`)
ABSOLUTE=$(cd $SCRIPT_PATH; pwd)
NEWBRANCH=$ABSOLUTE/newbranch
EXISTING=$ABSOLUTE/existing
CLOSED=$ABSOLUTE/closed
RESULT=0
CLEANUP="source $SCRIPT_PATH/clean-repos.sh $REPO1 $REPO2; rm $NEWBRANCH;  rm $EXISTING;  rm $CLOSED"

source $ABSOLUTE/init-repos.sh $REPO1 $REPO2
ret_code=$?
checkReturnCode $ret_code $CLEANUP

WRITE_RESULTS=$ABSOLUTE/write-file.sh

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

EXPECTED_NEW=("default")
EXPECTED_EXISTING=("default")
EXPECTED_CLOSED=("default")
I=0
while IFS='' read -r line || [[ -n "$line" ]]; do
    linearr=($line)
    if [ "${linearr[0]}" != "${EXPECTED_NEW[$I]}" ]; then
        RESULT=1
    fi
    let "I++"
done < "$NEWBRANCH"
if [! $i -eq ${EXPECTED_NEW[@]} ]; then
    RESULT=1
fi
I=0
while IFS='' read -r line || [[ -n "$line" ]]; do
    linearr=($line)

    if [ "${linearr[0]}"  != "${EXPECTED_EXISTING[$I]}" ]; then
        RESULT=1
    fi
    let "I++"
done < "$EXISTING"

if [! $i -eq ${EXPECTED_EXISTING[@]} ]; then
    RESULT=1
fi

I=0
while IFS='' read -r line || [[ -n "$line" ]]; do
    linearr=($line)

    if [ "${linearr[0]}" != "${EXPECTED_CLOSED[$I]}" ]; then
        RESULT=1
    fi
    let "I++"
done < "$CLOSED"

if [! $i -eq ${EXPECTED_CLOSED[@]} ]; then
    RESULT=1
fi

eval $CLEANUP
if [ $RESULT -eq 1 ]; then
    echo "FAILURE"
else
    echo "SUCCESS"
fi
