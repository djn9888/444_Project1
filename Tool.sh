# usr/bin/bash


finish(){

  ./killAllApm.sh

}
trap finish EXIT

startAPMs(){
   n=1
   while [ $n -le 6 ]
   do
     nohup ./APM$n 142.250.80.46 &>/dev/null &
     n=$(($n + 1))
   done
   echo 'All APMs running'
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

###### SYSTEM MONITOR SECTION ##########
#run System Monitor scrpit located in /monitor folder
nohup ./monitor/APM_Monitor.sh &>/dev/null &
echo 'Monitor running'


####### IFSTAT SECITON ######
#set ifstat update interval to every second.
#default is 60 seconds
ifstat -d 1


##### IOSTAT SECTION ######


#**testing, remove for PROD***
#loop for how ever many seconds specified in while 
x=1
while [ $x -le $a1 ]
do

echo $x
x=$(($x + 1))
sleep 1
done
