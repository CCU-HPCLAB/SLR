#!/bin/bash
sudo mkdir /home/pi/first
sudo chmod 777 /home/pi/first/
cp -a /mnt/gluster1/* /home/pi/first/
sudo chmod 777 /home/pi/first/*