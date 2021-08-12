#!/bin/bash
Host=$1
Primary_IP=$2
Redundant_IP=$3

echo "-----------------------"
	
	if [ $Host = "1" ]; then

		echo "setting enviroment of glusterfs of primary system..."
		sudo gluster peer probe $Redundant_IP
		sudo gluster volume create gv0 replica 2 $Primary_IP:/srv/gv0 $Redundant_IP:/srv/gv0 force
		sudo gluster volume start gv0
		sudo gluster volume set gv0 network.ping-timeout 1
		sudo mkdir -p /mnt/gluster1
		sudo mount -t glusterfs $Redundant_IP:/gv0 /mnt/gluster1
		sudo sed -i '$a#auto mount' /etc/fstab
		sudo sed -i '$a'$Redundant_IP':/gv0 /mnt/gluster1 glusterfs defaults 0 0' /etc/fstab
		
	else
		echo "setting enviroment of glusterfs of redundant system..."
		sudo mkdir -p /mnt/gluster1
		sudo mount -t glusterfs $Primary_IP:/gv0 /mnt/gluster1
		sudo sed -i '$a#auto mount' /etc/fstab
		sudo sed -i '$a'$Primary_IP':/gv0 /mnt/gluster1 glusterfs defaults 0 0' /etc/fstab
	fi
		sudo sed -i '$avolume gv0' /etc/glusterfs/glusterd.vol
		sudo sed -i '$a\  type protocol/client' /etc/glusterfs/glusterd.vol
		sudo sed -i '$a\  option ping-timeout 1' /etc/glusterfs/glusterd.vol
		sudo sed -i '$aend-volume' /etc/glusterfs/glusterd.vol
		sudo sed -i '16i sleep 15' /etc/rc.local
		sudo sed -i '17i sudo mount -a' /etc/rc.local
		sudo chmod 777 /mnt/gluster1
		echo "setting finished... "
	
	
	
