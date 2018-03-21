#!/bin/bash
network=`systemctl status network | grep Active | awk '{print $2}'`
network1="active"
brctl=`brctl show | sed -n '2,1p' |awk '{print $4}'`

rm -rf /etc/sysconfig/network-scripts/ifcfg-enp63s0 > /dev/null 2>&1
cp ./7/ifcfg-enp63s0 /etc/sysconfig/network-scripts/ifcfg-enp63s0
cp ./7/ifcfg-br0 /etc/sysconfig/network-scripts/ifcfg-br0

if [ -f /etc/sysconfig/network-scripts/ifcfg-br0 ]
then
	echo "IPADDR=$1" >> /etc/sysconfig/network-scripts/ifcfg-br0

	
else
	echo "/etc/sysconfig/network-scripts/ifcfg-br0 Not found!"
fi

systemctl stop NetworkManager
systemctl disable NetworkManager
chkconfig network on
systemctl restart network
if [ $network = $network1 ]
then
	systemctl restart network
	if [ $network = $network1 ]
	then
		#echo " success"
		if [ -z $brctl ]
		then
			echo "brctl setting error"
		else
			echo "brctl setting success"
		fi
	else
		echo "network server error"
	fi
else
	systemctl start network
	if [ $network = $network1 ]
	then
		echo "success"
	else
		echo "network server error"
	fi
fi
