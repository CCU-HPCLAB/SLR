#!/bin/bash

#運行檔案名稱要更改
PIDnumber=$(ps aux|awk 'NR>1 && $11 == "[DMTCP:test]" {print  $2}')
userinputA=30
userinputB=20
userinputC=10
#運行檔案名稱要更改
temp=$(top -b -n 1 -o %MEM  | awk 'NR>1 && $12 == "DMTCP:test" {print $10}')
temp2=$( top -b -n 1 -o %MEM | awk 'NR>1  {print  $1, $10}')
echo ${temp}
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

