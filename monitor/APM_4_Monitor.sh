# /usr/bin/bash

echo "%CPU    %MEM    Time">log/apm4Monit.log
echo "%CPU,%MEM,Time">log/apm4Monit.csv

while [ true ]
do
   x=""
   y=""
   sleep 5
   for pid in $(ps aux | grep -v grep | grep APM4 | awk '{print $3,$4}')
   do
     x="$x$pid     "
     y="$y$pid,"


   done
   x="$x$(date +'%m/%d/%Y %H:%M:%S')"
   y="$y$(date +'%m/%d/%Y %H:%M:%S')"

   echo "$x">>log/apm4Monit.log
   echo "$y">>log/apm4Monit.csv


done
