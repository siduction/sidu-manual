#! /bin/bash
ANSWER=$1
CMD=$2
PARAM=$3

echo "Welcome to the example script for $PARAM"
echo "I am waiting for 5 seconds"
sleep 5
touch $ANSWER
exit 0
