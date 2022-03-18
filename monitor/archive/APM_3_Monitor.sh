# /usr/bin/bash

echo "%CPU    %MEM    Time">log/apm3Monit.log
while [ true ]
do
   x=""
   sleep 5
   for pid in $( ps aux | grep -v grep | grep APM3 | awk '{print $3,$4}')
   do
     x="$x$pid     "

   done
   x="$x$(date +'%m/%d/%Y %H:%M:%S')"
   echo "$x">>log/apm3Monit.log

done
