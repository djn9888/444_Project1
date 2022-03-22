#! /usr/bin/bash


cleanup(){

  for pid in $(ps aux | grep -v grep | grep APM | awk '{print $2}' )
  do 
    kill $pid
    echo "$pid was killed"
 done

 for pid in $(ps aux | grep -v grep | grep -n ifstat | awk '{print $2}' )
 do 
   kill $pid
   echo "$pid was killed"
 done

}
trap cleanup EXIT

startAPMs(){
   n=1
   while [ $n -le 6 ]
   do
     nohup ./APM$n 142.250.80.46 &>/dev/null &
     n=$(($n + 1))
   done
   echo 'All APMs running'
}

writeSystemMetrics() {

   time=$1

   #output="$time"

   # network statistics section (-10 for now to remind us to fix it)
   net=$(ifstat ens192 -t 1 | awk '{if(NR==4) print $3,",",$5}')

   # hard disk section
   # measure hard disk writes in kB/section to the primary hard drive
   # kB_wrtn/s is the fourth column
   writes=$(iostat | grep sda | awk '{print $4}')

   # measure hard disk utilization
   space=$(df -m | grep /dev/mapper/centos-root | awk '{print $4}')

   output="$time,$net,$writes,$space,"

   echo "$output">>./log/system_metrics.csv

}

writeProcessMetrics(){


   times=$1
   n=(1 2 3 4 5 6)
      y="$times,"
      for apm in "${n[@]}"
      do
         for pid in $(ps aux | grep -v grep | grep APM"$apm" | awk '{print $3,$4}')
         do
           y="$y$pid,"

         done
      done

   times=$(($times+5))
   echo "$y">>log/apm1Monit.csv

}

# check for arguments and use first one in 
# while loop if present
a1=20
if [ $# -gt 0 ]
  then
  a1=$1
fi

####### START APM1-6 SECTION ########
#start APM processes by calling function
startAPMs

###### PROCESS MONITOR SECTION ##########
#run System Monitor scrpit located in /monitor folder
echo "Time,APM1%CPU,APM1%MEM,APM2%CPU,APM2%MEM,APM3%CPU,APM3%MEM,APM4%CPU,APM4%MEM,APM5%CPU,APM5%MEM,APM6%CPU,APM6%MEM,">log/apm1Monit.csv

#nohup ./monitor/APM_Monitor.sh &>/dev/null &
#echo 'Monitor running'


####### IFSTAT SECTION ######
#set ifstat update interval to every second.
#default is 60 seconds

ifstat -d 1

###### SYSTEM METRICS ######
# run system metrics script located in /monitor folder
# contains code for both network and hard disk stats
# nohup ./monitor/APM_system_monitor.sh &>/dev/null &
# echo 'System metrics monitor running'
echo "Time,RX Data Rate,TX Data Rate,Disk Writes,Disk Capacity,">./log/system_metrics.csv

#**testing, remove for PROD***
#loop for how ever many seconds specified in while 
x=1
while [ $x -le $a1 ]
do

if [ $(($x % 5)) -eq 0 ]; then
   writeSystemMetrics $x
   writeProcessMetrics $x
fi

echo $x
x=$(($x + 1))
sleep 1
done
