#!/bin/bash
cd /mnt/gluster1/
count=$(ls -lR|grep "^-"| wc -l)
echo ${count}