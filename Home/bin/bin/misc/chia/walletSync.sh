#!/bin/bash

numer=`/home/ash/Source/chia-blockchain/venv/bin/chia wallet show | \
  awk '/height/ {print $3}'`

denom=`/home/ash/Source/chia-blockchain/venv/bin/chia show -s | \
  awk '/Height/ {print $9}'`

ratio="$numer/$denom"

if [ $1 ]; then
  echo $ratio
  exit 0
fi

echo `bc -l <<< "scale=6; $ratio * 100"`
