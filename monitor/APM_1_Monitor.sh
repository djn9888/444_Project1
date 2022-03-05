# /usr/bin/bash

echo "%CPU    %MEM">log/apm1Monit.log
while [ true ]
do
   x=""
   sleep 1
   for pid in $(ps aux | grep -v grep | grep APM1 | awk '{print $3,$4}')
   do
     x="$x$pid    "

   done
   echo "$x"
   echo "$x">>log/apm1Monit.log

done
