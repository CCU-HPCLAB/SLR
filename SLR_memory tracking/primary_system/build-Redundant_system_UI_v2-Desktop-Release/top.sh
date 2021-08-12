#!/bin/bash

#運行檔案名稱要更改
PIDnumber=$(ps aux|awk 'NR>1 && $11 == "./test" {print  $2}')
userinputA=30
userinputB=20
userinputC=10
#運行檔案名稱要更改
temp=$(top -b -n 1 -o %MEM  | awk 'NR>1 && $12 == "test" {print $10}')
temp2=$( top -b -n 1 -o %MEM | awk 'NR>1  {print  $1, $10}')

limitemem=$(sed -n '2p' /home/pi/final.txt|awk '{print $1}' )
minimum=$(sed -n '1p' /home/pi/final.txt|awk '{print $1}' )


levelC=$(echo "($limitemem - $userinputC)" | bc -l)
levelB=$(echo "($limitemem - $userinputB)" | bc -l)
levelA=$(echo "($limitemem - $userinputA)" | bc -l)

#temp=70
if [ `echo "$temp >= $levelC" | bc` -eq 1 ]
then
	echo "danger"
elif [ `echo "$temp >= $levelB" | bc` -eq 1 ]
then
	echo "general"
else
	echo "ok"
fi

#count=8
#for (( i=1; i<=5; i )) ; do
#	p1=$count'p'
#	sort[i]=$(top -b -n 1 -o %MEM | sed -n $p1 | awk '{print  $10}')
#        PIDS[i]=$(top -b -n 1 -o %MEM | sed -n $p1 | awk '{print  $1}')
#	count=`expr $count + 1`
#	i=`expr $i + 1`
#done

#for (( i=1; i<=5; i )) ; do
#	echo "PIDS && sort="${PIDS[i]} "," ${sort[i]}
#	i=`expr $i + 1`
#done




#echo "PIDnumber="${PIDnumber}
#echo "maximum="${maximum}
#echo ${temp} >> /tmp/file.tmp 

