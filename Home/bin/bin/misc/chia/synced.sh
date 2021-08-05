#!/bin/bash

PERC="%"
if [ $1 ]; then
  PERC=""
fi

/opt/chia-blockchain/venv/bin/chia show -s | \
  sed 's/\.//g' | \
  awk '/Sync/ {print $5}' | \
  awk -v PERC="$PERC" 'BEGIN {FS="/"} ; {print 100*$1/$2 PERC}'
