#!/bin/bash

proclist=$(pgrep chrome)
chromesjekk=$(pgrep chrome | awk '{print $1}')
if [ -z "$chromesjekk" ]
then
echo "Chrome kjører ikke"
else
for loop in $proclist; do
faults=$(ps --no-headers -o maj_flt $loop)
if [ $faults -gt 1000 ]
then
echo "Chrome $loop har forårsaket $faults major page faults (mer enn 1000!)"
else
echo "Chrome $loop har forårsaket $faults major page faults"
fi
done
fi
