#!/bin/bash
Host_IP=$1
gateway=$2
netmask=$3
broadcast=$4
ssid=$5
psk=$6

echo "setting static ip..."
sudo sed -i '$aauto lo' /etc/network/interfaces 
sudo sed -i '$aiface lo inet loopback' /etc/network/interfaces
sudo sed -i '$aiface eth0 inet dhcp\n' /etc/network/interfaces
sudo sed -i '$aallow-hotplug wlan0' /etc/network/interfaces
sudo sed -i '$aiface wlan0 inet static' /etc/network/interfaces
sudo sed -i '$aaddress '$Host_IP   /etc/network/interfaces
sudo sed -i '$agateway '$gateway 	 /etc/network/interfaces
sudo sed -i '$anetmask '$netmask   /etc/network/interfaces
sudo sed -i '$abroadcast '$broadcast /etc/network/interfaces
sudo sed -i '$awpa-ssid "'$ssid'"'  /etc/network/interfaces
sudo sed -i '$awpa-psk "'$psk'"'  /etc/network/interfaces

echo "your setting are:"
cat /etc/network/interfaces
echo "setting finished..."
sudo /etc/init.d/networking restart
echo "Please reboot your raspberrypi..."
