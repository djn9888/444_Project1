# /usr/bin/bash

for pid in $(ps aux | grep -v grep | grep APM | awk '{print $2}' )
do 
   kill $pid
   echo "$pid was killed"
done
