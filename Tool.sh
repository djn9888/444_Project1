# usr/bin/bash


function finish {

./killAllApm.sh

}
trap finish EXIT

a1=20
if [ $# -gt 0 ]
  then
  a1=$1
fi

n=1
while [ $n -le 6 ]
do
 nohup ./APM$n 142.250.80.46 &>/dev/null &
 n=$(($n + 1))
done
echo 'All APMs running'



#run System Monitor srpits
#n=1
#while [ $n -le 6 ]
#do
#nohup ./monitor/APM_${n}_Monitor.sh &>/dev/null &
# n=$(($n + 1))
#done
nohup ./monitor/APM_Monitor.sh &>/dev/null &
echo 'Monitor running'


#**testing, remove for PROD***
#loop for how ever many seconds specified in while 
x=1
while [ $x -le $a1 ]
do

echo $x
x=$(($x + 1))
sleep 1
done
