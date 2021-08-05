#!/bin/bash

waitTime=${1:-5}
script="${@:2}"

tz="-4"

if [ -z $script ]; then
  echo "Usage: estPercent.sh <waitTime> <script>"
  exit 1
fi

clear
echo "Wait for initial readings"

lastRead=$($script)
lastTime=$(date +%s)
i=0

function calcTime() {
  dRead=`bc <<< "$thisRead - $lastRead"`
  dTime=`bc <<< "$thisTime - $lastTime"`

  rate=`bc -l <<< "scale=4; $dRead / $dTime * 60"`
  tTotal=`bc -l <<< "scale=4; 100 * $dTime / $dRead"`
  rSec=`bc -l <<< "$tTotal - $thisRead"`
  rMin=`bc -l <<< "scale=4; $rSec / 60"`
  rHours=`bc -l <<< "scale=4; $rMin / 60"`
  rDays=`bc -l <<< "scale=4; $rHours / 24"`
  dComp=`date -d "today $rSec seconds $tz hours" +'%D %H:%M'` # hours to account for timezone

  clear
  tput cup 0 0
  echo Reading \#$i -- $thisRead% done
  echo $dRead% in $dTime sec
  echo Rate: $rate %/min
  echo Done in: $rSec s, $rMin min, $rHours hr, $rDays days
  echo Complete at: $dComp
}

while :
do
  sleep $waitTime
  thisRead=$($script)
  thisTime=$(date +%s)
  ((i++))

  if [ $thisRead -eq 100 ]; then
    echo "Done!"
    exit 0
  fi

  calcTime &
done
