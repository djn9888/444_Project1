#! /usr/bin/bash

echo "Time,RX Data Rate,TX Data Rate,Disk Writes,Disk Capacity,">../log/system_metrics.csv

time=5

# infinite while (killed by other process)
while true
do

   sleep 4.5

   output="$time"

   # network statistics section (-10 for now to remind us to fix it)
   output="$output,0,0,"

   # hard disk section
   # measure hard disk writes in kB/section to the primary hard drive
   # kB_wrtn/s is the fourth column
   writes=$(iostat | grep sda | awk '{print $4}')

   # measure hard disk utilization
   space=$(df -m | grep /dev/mapper/centos-root | awk '{print $4}')
   
   output="$output$writes,$space,"

   time=$(($time+5))
   echo "$output">>../log/system_metrics.csv

done 
