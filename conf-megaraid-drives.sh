#!/bin/bash
MCLI="/opt/MegaRAID/MegaCli/MegaCli64"

# Check to see if MegaCli is even installed
if [[ -e /opt/MegaRAID/MegaCli/MegaCli64 ]]; then
  continue
else
  echo "LSI MegaRAID MegaCli not installed!  Exiting!"
  exit
fi

# Declaring an array; To be populated with drives
declare -a drives

# For loops that print out each drive enclosure and slot number
for x in `seq 8 9`; do
  if [[ $x = 8 ]]; then
    for y in `seq 0 20`; do
    drives+="$x:$y "
    done
  elif [[ $x = 9 ]]; then
    for y in `seq 0 23`; do
    drives+="$x:$y "
    done
  fi
done

for drive in ${drives[*]}; do
  echo "Configuring drive $drive..."
  $MCLI -PDMakeGood -PhysDrv[$drive] -Force -aALL
  $MCLI -PDMakeJBOD -PhysDrv[$drive] -aALL
done


