#!/bin/bash

waitTime=${1:-5}

clear
echo "Wait for initial readings"

lastRead=$(./synced.sh 1)
lastTime=$(date +%s)
i=0

function calcTime() {
  dRead=`echo $thisRead - $lastRead | bc`
  dTime=`echo $thisTime - $lastTime | bc`

  rate=`bc -l <<< "scale=4; $dRead / $dTime * 3600"`
  tTotal=`bc -l <<< "scale=4; 100 * $dTime / $dRead"`
  rSec=`bc -l <<< "$tTotal - $thisRead"`
  rHours=`bc -l <<< "scale=4; $rSec / 60 / 60"`
  rDays=`bc -l <<< "scale=4; $rHours / 24"`
  dComp=`date -d "today 71014.15347 seconds" +'%D %H:%M'`

  clear
  tput cup 0 0
  echo Reading $i -- $thisRead% done
  echo $dRead% in $dTime sec
  echo Rate: $rate %/min
  echo Done in: $rSec s, $rHours hr, $rDays days
  echo Complete at: $dComp
}

while :
do
  sleep $waitTime
  thisRead=$(./synced.sh 1)
  thisTime=$(date +%s)
  ((i++))
  calcTime
done
