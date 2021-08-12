#!/usr/bin/bash
sudo apt-get install gcc -y
sudo apt-get install g++ -y
wget https://ftp.gnu.org/gnu/glibc/glibc-2.31.tar.gz
mkdir /home/pi/glibc-bulid/
tar -xvf /home/pi/glibc-2.31.tar.gz
cd /home/pi/glibc-bulid/
sudo apt-get install make -y
sudo apt-get install gawk -y
sudo apt-get install bison -y
../glibc-2.31/configure --prefix=/home/pi/glibc-bulid/
make -j3
sudo make install
