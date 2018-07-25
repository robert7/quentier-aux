#!/bin/bash

PID=${1}
if [ -z "${PID}" ]; then
    echo pass PID as 1st param..
    exit 1
fi

while true ; do
  F=tbstack-`date +'%Y%m%d_%H%M%S'`.log
  echo Capturing state of PID=$PID in $F
  sudo tbstack $PID >$F
  sleep 1
done
