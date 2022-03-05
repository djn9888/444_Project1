# usr/bin/bash


function finish {

./killAllApm.sh

}
trap finish EXIT


n=1
while [ $n -le 6 ]
do
 nohup ./APM$n 142.250.80.46 &>/dev/null &
 n=$(($n + 1))
done
echo 'All APMs running'



#run monitor srpits
n=1
while [ $n -le 6 ]
do
nohup ./monitor/APM_${n}_Monitor.sh &>/dev/null &
 n=$(($n + 1))
done
echo 'All Monitors running'


#**testing, remove fro PROD***
#loop for how ever many seconds specified in while 
x=1
while [ $x -le 20 ]
do

echo $x
x=$(($x + 1))
sleep 1
done
