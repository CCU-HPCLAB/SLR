#!/bin/bash
software=$1

case $software in
 1)
	command -v gluster &> /dev/null
	if [ "$?" = "1" ]; then
		echo "installing glusterfs..."
		sudo apt-get install glusterfs-server -y
		echo "-----------------------"
		echo "glusterfs installed successfully..."
	
	else 
		echo "glusterfs has installed!"
	fi
	;;
 2)
	command -v dmtcp_launch &> /dev/null
	if [ "$?" = "1" ]; then
		echo "installing DMTCP..."
		unzip dmtcp-master2.zip
		cd ./dmtcp-master
		./configure CFLAGS=-march=armv7-a
		make -j3
		sudo make install
		echo "DMTCP installed successfully..."
		echo "Setting DMtCP enviromental configuration..."
		sudo mkdir /dmtcp
		sudo chmod 777 /dmtcp
	else
		echo "DMTCP has installed!"
	fi
	;;
 3)
	command -v watchdog &> /dev/null
	if [ "$?" = "1" ]; then
		echo "installing Watchdog..."
		sudo sed -i '$a#watchdog' /boot/config.txt
		sudo sed -i '$adtparam=watchdog=on' /boot/config.txt
		sudo modprobe bcm2835_wdt
		sudo apt-get install watchdog -y
		echo "Watchdog installed successfully..."
		echo "Setting watchdog enviromental configuration..."
		sudo sed -i 's/#watchdog-device/watchdog-device/g' /etc/watchdog.conf 
		sudo sed -i 's/#max-load/max-load/g' /etc/watchdog.conf 
		sudo cp -r /etc/xdg/lxsession ~/.config/
		sudo sed -i '$a@sleep(10)' ~/.config/lxsession/LXDE-pi/autostart
		sudo sed -i '$a@@lxterminal -e' ~/.config/lxsession/LXDE-pi/autostart
		sudo service watchdog start
		sudo update-rc.d watchdog defaults
		echo "Setting finished..."
		
	else
		echo "Watchdog has installed!"
	fi
	;;
	
esac
