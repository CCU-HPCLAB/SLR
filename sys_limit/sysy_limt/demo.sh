# 宣告使用 /bin/bash
# 注意:一定要在./demo.sh(例如./demo.sh 3) 後面輸入分析檔案有幾個，還要安裝sudo apt-get install bc
#!/bin/bash
sudo chmod 777 /home/pi/sysy_limt/log/*

counter=1
final=0
start=0
file_number=1
fix=1
test=1
i=0
loop=0
percentage=0
AVG=0
until [ $counter -gt 100 ]; do
   #echo $counter
   WC=$(wc -l /home/pi/sysy_limt/log/$file_number | awk '{print $1}')
   echo ${WC}

        p=$counter
        p1=$p'p'
        #echo ${p1}
	temp=$(sed -n $p1 /home/pi/sysy_limt/log/$file_number)

	if [ $counter -gt $WC ]; #輸入文件有幾個數值-1
	then 
		
		
		final=`expr $p - 1`
		final1=$final'p'
		array[$i]=$(sed -n 1p /home/pi/sysy_limt/log/$file_number)
		i=`expr $i + 1`
		array[$i]=$(sed -n $final1 /home/pi/sysy_limt/log/$file_number)
		i=`expr $i + 1`		
		file_number=`expr $file_number + 1`
		final=0		
		p=$fix
		counter=$fix
		WC=0
	fi

	if [ $file_number -gt $1 ];
	then
		break
	fi

	#temp1='s/'$temp'/'$counter.jpg'/'
	#rename $temp1 *.jpg
	echo ${temp}
        counter=`expr $counter + 1`
done


#===write file====
loop=`expr $1 \* 2`
for (( j=0; j<$loop; j )) ; do 
#echo ${array[$j]} 
#echo ${array[$j]} >> /home/pi/sysy_limt/log/example.txt
j=`expr $j + 1`
done

#===計算平均數====
y=0
sum=0
minimum=100
for (( j=0; j<$loop; j )) ; do 
y=`expr $j + 1`
percentage=$(echo "scale=3; ${array[$y]} / ${array[$j]}" | bc)
percentage=$(echo "($percentage * 100)" | bc -l)
sum=$(echo "($percentage + $sum)" | bc -l)
AVG=$(echo "($sum / $1)" | bc -l)
echo percentage ${percentage}
j=`expr $j + 2`
		#===找出最小值====
if [ `echo "$minimum > $percentage" | bc` -eq 1 ]
then
	minimum=$percentage
fi
done

echo "minimum"
echo ${minimum}

#===write AVG && MIN====
echo ${AVG}
echo "" > //home/pi/sysy_limt/log/example.txt
echo ${minimum} > //home/pi/sysy_limt/log/example.txt
echo ${AVG} >> //home/pi/sysy_limt/log/example.txt


