#!/bin/bash
network=`service network status | grep Active | awk '{print $2}'`
network1="active"
brctl=`brctl show | sed -n '2,1p' |awk '{print $4}'`

rm -rf /etc/sysconfig/network-scripts/ifcfg-eth0 > /dev/null 2>&1
cp ./6-5/ifcfg-eth0 /etc/sysconfig/network-scripts/ifcfg-eth0
cp ./6-5/ifcfg-br0 /etc/sysconfig/network-scripts/ifcfg-br0

if [ -f /etc/sysconfig/network-scripts/ifcfg-br0 ]
then
	echo "IPADDR=$1" >> /etc/sysconfig/network-scripts/ifcfg-br0

	
else
	echo "/etc/sysconfig/network-scripts/ifcfg-br0 Not found!"
fi

service NetworkManager stop
chkconfig NetworkManager off
chkconfig network on
service network restart
service network start
if [ $network = $network1 ]
then
		if [ -z $brctl ]
		then
			echo "brctl setting error"
		else
			echo "brctl setting success"
		fi
else
	service network start
	if [ $network = $network1 ]
	then
		
		if [ -z $brctl ]
		then
			echo "brctl setting error"
		else
			echo "brctl setting success"
		fi
	else
		echo "network server error"
	fi
fi
