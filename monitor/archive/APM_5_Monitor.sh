# /usr/bin/bash

echo "%CPU    %MEM    Time">log/apm5Monit.log
echo "%CPU,%MEM,Time">log/apm5Monit.csv

while [ true ]
do
   x=""
   y=""
   sleep 5
   for pid in $(ps aux | grep -v grep | grep APM5 | awk '{print $3,$4}')
   do
     x="$x$pid     "
     y="$y$pid,"


   done
   x="$x$(date +'%m/%d/%Y %H:%M:%S')"
   y="$y$(date +'%m/%d/%Y %H:%M:%S')"

   echo "$x">>log/apm5Monit.log
   echo "$y">>log/apm5Monit.csv


done
