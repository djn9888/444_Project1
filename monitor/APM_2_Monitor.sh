# /usr/bin/bash

echo "%CPU    %MEM">log/apm2Monit.log
echo "%CPU    %MEM"
while [ true ]
do
   x=""
   sleep 1
   for pid in $(ps aux | grep -v grep | grep APM2 | awk '{print $3,$4}')
   do
     x="$x$pid    "

   done
   echo "$x"
   echo "$x">>log/apm2Monit.log

done
