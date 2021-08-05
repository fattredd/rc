#!/bin/bash

waitTime=${1:-5}

lastRead=$(./synced.sh 1)
lastTime=$(date +%s)
i=0

function calcTime() {
  dRead=`echo $thisRead - $lastRead | bc`
  dTime=`echo $thisTime - $lastTime | bc`

  rate=`echo "scale=4; $dRead / $dTime * 3600" | bc -l`
  tTotal=`echo "scale=4; 100 * $dTime / $dRead" | bc -l`
  rSec=`echo "$tTotal - $thisRead" | bc -l`
  rHours=`echo "scale=4; $rSec / 60 / 60" | bc -l`
  rDays=`echo "scale=4; $rHours / 24" | bc -l`

  clear
  tput cup 0 0
  echo Reading $i -- $thisRead% done
  echo $dRead% in $dTime sec
  echo Rate: $rate %/min
  echo Done in: $rSec s, $rHours hr, $rDays days
}

while :
do
  sleep $waitTime
  thisRead=$(./synced.sh 1)
  thisTime=$(date +%s)
  ((i++))
  calcTime
done
