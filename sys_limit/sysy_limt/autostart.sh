# 宣告使用 /bin/bash
# 注意:一定要在./autostart.sh(例如./autostart.sh 3) 後面輸入分析檔案有幾個，還要安裝sudo apt-get install bc
#!/bin/bash
sleep 5
sudo chmod 777 /home/pi/sysy_limt/log/*
temp=$(sed -n 1p /home/pi/sysy_limt/parameter)
cd /home/pi/sysy_limt/log/
filenumber=$(ls -l |grep "^-"|wc -l)
echo filenumber${filenumber}

if [ $filenumber -gt $temp ]; #輸入文件有幾個數值-1
then 
	echo "This analysis has been completed!!"
else
	echo ${temp}
	cd /home/pi/sysy_limt/
	sudo ./for_stress $temp
fi


