# /usr/bin/bash

echo "Time,APM1%CPU,APM1%MEM,APM2%CPU,APM2%MEM,APM3%CPU,APM3%MEM,APM4%CPU,APM4%MEM,APM5%CPU,APM5%MEM,APM6%CPU,APM6%MEM,">../log/apm1Monit.csv


times=5
n=(1 2 3 4 5 6)
while  [ true ]
do
   sleep 4.5

   y="$times,"
   for apm in "${n[@]}"
   do   
      echo "$apm"
      for pid in $(ps aux | grep -v grep | grep APM"$apm" | awk '{print $3,$4}')
      do
        y="$y$pid,"

      done
   done
   

   times=$(($times+5))
   echo "$y">>../log/apm1Monit.csv


done

