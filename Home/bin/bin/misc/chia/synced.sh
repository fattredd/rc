#!/bin/bash

PERC="%"

if [ $1 ]; then
  PERC=""
fi

ratio=`/home/ash/Source/chia-blockchain/venv/bin/chia show -s | sed 's/\.//g' | awk '/Sync/ {print $5}'`

if [ $2 ]; then
  echo $ratio
  exit 0
fi
echo `echo $ratio | awk -v PERC="$PERC" 'BEGIN {FS="/"} ; {print 100*$1/$2 PERC}'`
